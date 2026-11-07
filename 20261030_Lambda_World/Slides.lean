import VersoSlides
import Verso.Doc.Concrete
import Verso.Doc.Elab
import Lean

open VersoSlides
open Verso Doc Elab

set_option maxHeartbeats 800000
set_option linter.unusedVariables false
set_option verso.code.warnLineLength 100

@[directive]
public meta def footer : Elab.DirectiveExpanderOf Unit
  | (), stxs => do
  let contents ← stxs.mapM elabBlock
  ``(Block.other (VersoSlides.BlockExt.wrap #[("class", "slide-footer")]) #[$contents,*])

/-- Splits one line of Verso source into tokens for `slideSource`, each with an optional
CSS class suffix (`tok-…`). Deliberately simple: it covers what that slide contains. -/
meta def versoLineTokens (l : String) : Array (Option String × String) :=
  if l.startsWith "import " then
    #[(some "kw", "import"), (none, (l.drop 6).toString)]
  else if l.startsWith "#doc " then
    match l.splitOn "\"" with
    | [pre, title, _] =>
      let genre := ((pre.splitOn "(").getD 1 "").splitOn ")" |>.headD ""
      #[(some "kw", "#doc"), (none, " ("), (some "const", genre), (none, ") "),
        (some "str", "\"" ++ title ++ "\""), (none, " "), (some "kw", "=>")]
    | _ => #[(none, l)]
  else if l.startsWith "# " then
    #[(some "heading", l)]
  else if l.startsWith ":::" then
    let colons := String.ofList (l.toList.takeWhile (· == ':'))
    #[(some "kw", colons), (some "const", (l.drop colons.length).toString)]
  else if l == "[...]" then
    #[(some "comment", l)]
  else
    -- `*emphasis*`: every other `*`-separated segment is emphasized
    (l.splitOn "*").toArray.mapIdx fun i seg =>
      if i % 2 == 1 then (some "emph", "*" ++ seg ++ "*") else (none, seg)

/-- Shows the source of the slide it appears in: the lines from the enclosing
`# ` heading up to the next one, read from this file while the slides are built.
They are preceded by a preamble of the file's first `import` and its `#doc` line. -/
@[directive]
public meta def slideSource : Elab.DirectiveExpanderOf Unit
  | (), _ => do
  let some pos := (← Lean.getRef).getPos?
    | throwError "slideSource: no source position"
  let fm ← Lean.getFileMap
  let lines := (fm.source.splitOn "\n").toArray
  let here := (fm.toPosition pos).line - 1
  let isHeading (l : String) := l.startsWith "# "
  let start := (List.range (here + 1)).reverse.find? (fun i => isHeading lines[i]!) |>.getD here
  let stop := (List.range' (here + 1) (lines.size - here - 1)).find? (fun i => isHeading lines[i]!)
    |>.getD lines.size
  let slide := "\n".intercalate (lines.extract start stop).toList
  let some imp := lines.find? (·.startsWith "import ")
    | throwError "slideSource: no import found"
  let some docCmd := lines.find? (·.startsWith "#doc ")
    | throwError "slideSource: no #doc command found"
  let text := s!"{imp}\n\n{docCmd}\n\n[...]\n\n{slide}"
  -- One paragraph per line, one styled span per token (see `.own-source` in `overrides.css`).
  let paras ← (text.trimAsciiEnd.toString.splitOn "\n").toArray.mapM fun l => do
    let toks := (versoLineTokens l).filter (!·.2.isEmpty)
    let toks := if toks.isEmpty then #[(none, " ")] else toks
    let inls ← toks.mapM fun
      | (none, t) => ``(Inline.text $(Lean.quote t))
      | (some c, t) =>
        ``(Inline.other (VersoSlides.InlineExt.styled #[("class", $(Lean.quote ("tok-" ++ c)))])
            #[Inline.text $(Lean.quote t)])
    ``(Block.para #[$inls,*])
  ``(Block.other (VersoSlides.BlockExt.wrap #[("class", "own-source")]) #[$paras,*])

#doc (Slides) "Customizing the World with Lean" =>

# Customizing the World with Lean

%%%
backgroundColor := "#0073A3"
%%%

Sebastian Ullrich

Head of Engineering, Lean FRO

Chief Lean Officer, &Truth

Lambda World · October 30, 2026

# Lean

... is an interactive theorem prover for verification of mathematics and code

:::::class "news"
::::hstack
{image "static/images/flt-anthropic.jpg"}[Formalizing Fermat's Last Theorem (Anthropic)]

{image "static/images/navier-stokes-openai.jpg"}[On the Navier-Stokes Millennium Prize Problem (OpenAI)]
::::
:::::

:::fragment (index := 1)
It is also a general-purpose programming language {fragment (index := 2)}[and its own *metaprogramming language*]
:::

:::fragment (index := 2)
This talk is about the latter
:::

# A Story from PLDI 2025

::::::::::class "story"
:::::::::hstack
::::::::vstack
::::::fragment fadeIn (index := 2)
:::::class "bubble" "tail-right"
Could I show you some code?
:::::
::::::
::::::fragment fadeIn (index := 1)
:::::class "person"
{image "static/images/ilya.jpg"}[Ilya Sergey] Ilya Sergey (NUS)
:::::
::::::
::::::fragment fadeIn (index := 5)
:::::class "bubble" "below"
It's Lean!
:::::
::::::
::::::::
::::::::fragment fadeIn (index := 3)
```
method Predicate.toArray (mut s: α → Bool)
  return (res: Array α)
  ensures ∀ x, sOld x ↔ x ∈ res do
  let mut res := #[]
  while ∃ x, s x
    invariant ∀ x, sOld x ↔ x ∈ res ∨ s x do
    let x :| s x
    res := res.push x
    s := fun y => if y = x then false else s y
  return res
```
::::::::
::::::::vstack
::::::fragment fadeIn (index := 4)
:::::class "bubble" "thought" "tail-left"
Why is he showing us Dafny code?
:::::
::::::
:::::::hstack
::::::class "person"
{image "static/images/leo.jpg"}[Leo] Leo
::::::
::::::class "person"
{image "static/images/sebastian.jpg"}[Sebastian] Sebastian
::::::
:::::::
::::::fragment fadeIn (index := 6)
:::::class "bubble" "below" "tail-both"
Whaaat?!
:::::
::::::
::::::::
:::::::::
::::::::::

# Lean Is Implemented in Lean

Parser, elaborator, tactics, language server: *all written in Lean*

The built-in features use the *same extension mechanisms* that are available to users

```lean
macro_rules
  | `(if let $pat := $d then $t else $e) =>
    `(match $d:term with | $pat => $t | _ => $e)
```

*If we can build it, so can you*, without forking the compiler

:::class "space-above"
_Focus of my PhD thesis: "An Extensible Theorem Proving Frontend"_
:::

# Extending Lean

%%%
backgroundColor := "#0073A3"
%%%

_How Lean processes a file and where you can change that_

# The Frontend Pipeline

:::::class "pipeline"
::::hstack
:::class "step" "highlight"
Parser
:::
:::class "arrow"
→
:::
:::class "step" "highlight"
Macros
:::
:::class "arrow"
→
:::
:::class "step" "highlight"
Elaborator
:::
:::class "arrow"
→
:::
:::class "step"
Kernel
:::
::::
:::::

- *Parser*: extensible grammar; new syntax can be declared anywhere
- *Macros*: syntax-to-syntax rewriting, hygienic by default
- *Elaborator*: syntax to typed core terms, with full access to type inference and unification
- *Kernel*: small, fixed, and *not* extensible; the safety net for everything above

Plus: the *language server* and the *infoview* UI

# Notation

```lean -show
namespace Notation
```

```lean
infixl:65 " +++ " => List.append

#eval [1, 2] +++ [3]
notation "‖" x "‖" => Int.natAbs x

#eval ‖-42‖
```

```lean -show
end Notation
```

# Syntax and Macros

```lean
syntax "[" term " | " ident " ← " term "]" : term
syntax "[" term " | " ident " ← " term ", " term "]" : term

macro_rules
  | `([$f | $x ← $xs]) =>
    `(List.map (fun $x => $f) $xs)
  | `([$f | $x ← $xs, $p]) =>
    `(List.map (fun $x => $f) (List.filter (fun $x => $p) $xs))

#eval [x * x | x ← [1, 2, 3, 4, 5, 6], x % 2 == 0]
```

`syntax` extends the *grammar*, `macro_rules` gives it *meaning*

::::fragment (index := 1)
`macro` is just a macro for `syntax` + `macro_rules`

`notation` is just a macro for a simple `macro`

`infixl` is just a macro for a simple `notation`
::::

# Hygiene {class "cite"}[\[Ullrich & de Moura, IJCAR'20\]]

```lean
macro "twice!" e:term : term => `(let y := 2; $e * y)

#eval let y := 5; twice! y
```

::::fragment (index := 1)
Naive expansion would yield `let y := 5; let y := 2; y * y`, i.e. `4`
::::

::::fragment (index := 2)
The macro's `y` *cannot capture* the user's `y`

Lean 4 adapts Racket's algorithm for automatic hygiene without any knowledge of the grammar's _binding structure_ {class "cite"}[\[Flatt, POPL'16\]]

Especially important for custom *tactics*, i.e. proof automation:
helper facts in a tactic macro do not leak into the caller's context
::::

# Macros Are Just Lean Functions

```lean
open Lean in
partial def printfAux (acc : Term) : List Char → MacroM Term
  | [] => pure acc
  | '%' :: 'd' :: cs => withFreshMacroScope do
    `(fun (x : Nat) => $(← printfAux (← `($acc ++ toString x)) cs))
  | '%' :: 's' :: cs => withFreshMacroScope do
    `(fun (x : String) => $(← printfAux (← `($acc ++ x)) cs))
  | cs =>
    let lit := cs.takeWhile (· != '%')
    let lit := if lit.isEmpty then cs.take 1 else lit
    do printfAux (← `($acc ++ $(quote (String.ofList lit)))) (cs.drop lit.length)

macro:max "printf! " s:str : term => do
  printfAux (← `("")) s.getString.toList
```

# Type-Safe `printf`

The format string is parsed *at compile time*, by ordinary Lean code

```lean -stretch
#check printf! "%s is %d years old"
```

:::fragment
```lean -stretch
#eval printf! "%s is %d years old" "Lean" 13
```
:::

:::fragment
```lean -stretch
/--
error: Application type mismatch: The argument
  "oops"
has type
  String
but is expected to have type
  Nat
in the application
  (fun x => "" ++ toString x) "oops"
-/
#guard_msgs in
#eval printf! "%d" "oops"
```
:::

# Elaborators

Macros only see *syntax*. Elaborators see *meaning*

- Inspect and create *typed terms* (`Expr`)
- Ask for types, unify, synthesize type class instances
- Query and extend the *environment*: all declarations, attributes, …

A stack of monads gives access to these: `CoreM`, `MetaM`, `TermElabM`, `CommandElabM`, `TacticM`

# A Custom Command

```lean
open Lean Elab Command in
elab "#count_theorems" : command => do
  let env ← getEnv
  let n : Nat := env.constants.fold (init := 0) fun n _ c =>
    if c matches .thmInfo _ then n + 1 else n
  logInfo m!"{n} theorems in scope"

#count_theorems
```

# Proofs Are Interactive

%%%
visibility := "hidden"  -- tactic part commented out for now
%%%

```lean
example (p q : Prop) (hp : p) (hq : q) : p ∧ q := by
  constructor
-- ^ !click
  exact hp
-- ^ !click
  exact hq
-- ^ !click
```

A *tactic* transforms the current *proof state*

Tactics are *metaprograms*: Lean code that builds proof terms

# Tactic Macros

%%%
visibility := "hidden"  -- tactic part commented out for now
%%%

```lean
macro "triv" : tactic =>
  `(tactic| first | rfl | assumption | omega | decide)

example (n : Nat) : n < n + 1 := by triv
example : 2 ^ 10 = 1024 := by triv
```

Existing tactics can also be *extended*:

```lean
macro_rules | `(tactic| trivial) => `(tactic| omega)
```

# Writing a Tactic From Scratch

%%%
visibility := "hidden"  -- tactic part commented out for now
%%%

```lean
open Lean Elab Tactic Meta in
elab "my_assumption" : tactic => do
  let goal ← getMainGoal
  for h in ← getLCtx do
    if !h.isImplementationDetail then
      if ← isDefEq h.type (← goal.getType) then
        goal.assign h.toExpr
        return
  throwError "no matching hypothesis"
-- !fragment
example (p q : Prop) (hp : p) (hq : q) : q := by
  my_assumption
```

The kernel *re-checks* the resulting proof: a buggy tactic cannot prove false things

# More Extension Points

- *Attributes* and *environment extensions*: `@[simp]`, `@[grind]`, your own databases of lemmas
- *Deriving handlers*: `deriving Repr, BEq, Hashable, ToJson, …`
- *Linters*: project-specific style and correctness checks
- *Code actions* and *"Try this"* suggestions in the editor
- *Widgets*: custom interactive UI in the infoview, written in Lean (plus a bit of JS)

# Applications

%%%
backgroundColor := "#0073A3"
%%%

_What People Have Built_

# Mathlib

Mathematical notation that looks like the textbook: `∑ i ∈ Finset.range n, i`, `∫ x in a..b, f x`, …

Domain-specific automation, all written in Lean:

- *Tactics*: `ring`, `field_simp`, `linarith`, `positivity`, `norm_num`, `gcongr`, …
- *Attribute-driven proof search*: `fun_prop`, `continuity`, `measurability` over lemmas users tag themselves
- *Code generation*: `@[to_additive]` derives additive versions of multiplicative theorems, `@[simps]` derives simp lemmas for definitions
- *Linters* enforcing Mathlib's conventions: `unusedTactic`, `flexible` (no `rw` after a non-terminal `simp`), `multiGoal`, `directoryDependency`

# Velvet: Verified Imperative Programs {class "cite"}[\[Gladshtein et al, CAV'26\]]

::::::class "velvet"
:::::hstack
```
method insertionSort (arr : Array Int)
  returns (res : Array Int)
  requires arr.size > 0
  ensures SortedUpTo res res.size
  ensures sameElems res arr
do
  let mut res := arr
  let mut n : Nat := 1
  while n ≠ res.size
    invariant res.size = arr.size
    invariant SortedUpTo res n
    invariant sameElems res arr
  do
    ...
    n := n + 1
  return res

prove_correct insertionSort by
  velvet_vcgen [insertionSort] with try finish
```

- Imperative code with contracts and loop invariants, *embedded in Lean*
- Programs compile and run; `#derive_tester_for` *tests* contracts before you prove them
- SMT-style automation, with a fall-back to interactive proofs
- A proved method yields an ordinary Lean theorem, `insertionSort.spec`
:::::
::::::

# Veil: Distributed Protocols {class "cite"}[\[Pîrlea et al, CAV'25\]]

::::::class "velvet veil"
:::::hstack
{image "static/images/veil-example.png" (height := "62vh")}[Veil: ring leader election]

- A *DSL* for specifying and verifying distributed protocols, embedded in Lean
- Properties as `safety` and `invariant` clauses in decidable fragments of first-order logic
- *Testing* first: `#model_check` explores small instances, `sat`/`unsat trace` asks SMT about bounded executions; counterexamples show up in the infoview
- `#check_invariants` proves inductive invariants *push-button* via SMT, with a fall-back to interactive proofs
:::::
::::::

# ProofWidgets: Custom Infoview UI {class "cite"}[\[Nawrocki et al, ITP'23\]]

{image "static/images/proofwidgets-rbtree.png" (height := "50vh")}[ProofWidgets: red-black trees in the infoview]

A widget shows subterms of the goal *as red-black trees*, and you can click into them

```
#html jsx%{<b>You can use HTML in Lean {.text s!"{1 + 3}"}!</b>}
```

# Verso

A documentation authoring tool, as a *Lean DSL*

Code examples are *elaborated*: they cannot go stale, and you can click on them

Used for the Lean reference manual, the Lean website, … and this talk

:::slideSource
:::

# Verso: Replacing the Parser

```lean -show
namespace ParserSlide
open Lean Parser Elab Command
-- Stand-ins for Verso's private helpers, so the excerpt below elaborates here.
def replaceCategoryParser (cat : Name) (p : ParserFn) : CommandElabM Unit := pure ()
def versoBlockCommandFn : ParserFn := fun _ s => s
-- `… stmts` is just `do stmts`: lets the slide elide part of Verso's code.
local macro "… " d:doSeq : term => `(do $d)
```

```lean -panel -stretch
elab_rules : command
  | `(command|#doc ( $genreSyntax:term ) $title:str =>%$tok) => …
    replaceCategoryParser `command versoBlockCommandFn
```

```lean -show
end ParserSlide
```

`#doc` swaps out the parser for Lean's `command` category *for the rest of the file*

Each block of markup becomes a "command": Lean's *incremental re-checking* works for documents for free

Inside Lean code blocks, the original parser is swapped back in

# Verso: Every Other Hook

- *Attributes*: `@[directive]`, `@[role]`, `@[code_block]` register new markup, like `slideSource` before
- *Elaborator*: nested use of Lean's own elaborator, capture and post-processing of produced metadata
- *Language server*: own handlers for hover, go-to-definition, outline, folding and semantic highlighting
- *Code actions* and *linters*: renumber lists, fix directive nesting, typography suggestions

# Demo

%%%
backgroundColor := "#0073A3"
%%%

_From widget to hosted Verso doc_

# Conclusion

Lean is *extensible from within itself*: parser, macros, elaborators, tactics, UI

:::class "space-above"
The same mechanisms power the core language and *user libraries*
:::

:::class "space-above"
The kernel stays small: *extensions cannot compromise soundness*
:::

# Thank You

%%%
backgroundColor := "#0073A3"
%%%

lean-lang.org | leanprover.zulipchat.com
