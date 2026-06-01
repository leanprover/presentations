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

#doc (Slides) "Theorem Proving in Industry with Lean" =>

# Theorem Proving in Industry with Lean

%%%
backgroundColor := "#0073A3"
%%%

Sebastian Ullrich

Head of Engineering, Lean FRO

Dutch Formal Methods Day · June 4, 2026

# zlib in Lean

A *general-purpose AI* autonomously converted *zlib* (C compression library) to Lean, passed the test suite, and *proved* the code correct

```
theorem zlib_decompressSingle_compress (data : ByteArray) (level : UInt8)
    (maxOutputSize : Nat) (hsize : data.size ≤ maxOutputSize) :
  ZlibDecode.decompressSingle (ZlibEncode.compress data level) maxOutputSize =
  .ok data
```

[github.com/kim-em/lean-zip](https://github.com/kim-em/lean-zip)

Blog post: [When AI Writes the World's Software, Who Verifies It?](https://leodemoura.github.io/blog/2026-2-28-when-ai-writes-the-worlds-software-who-verifies-it/)

# What is Lean?
_A programming language and a proof assistant_

Same language for code and proofs

Lean is implemented in Lean, enabling *unprecedented extensibility*

Lean is *scalable*

Lean has a small *trusted kernel*

# Multiple Independent Kernels
- The *reference kernel* (C++)
- *`nanoda`* (Rust)
- *`lean4lean`* (Lean)
- *`nanobruijn`* (Rust)
- and more

[arena.lean-lang.org](https://arena.lean-lang.org) hosts independent kernel implementations

Anyone can build a kernel and submit it

*Disagreement between independent kernels exposes bugs that neither would catch alone*

# The State of Lean
*250,000+* unique installations: [VS Code](https://marketplace.visualstudio.com/items?itemName=leanprover.lean4) (143K) + [Open VSX](https://open-vsx.org/extension/leanprover/lean4) (107K)

*9,000+* GitHub repositories depending on Lean

Industry: AWS, Google, Microsoft, Mistral, Nethermind, Galois, others

# Lean Beginnings

%%%
backgroundColor := "#0073A3"
%%%

_How did we get here?_

# Before Lean, there was Z3

Z3 is a *state-of-the-art SMT solver* created by Leonardo de Moura

Z3 powered bug-finding pipelines at Microsoft, catching thousands of defects

But for whole-program verification, *proofs were too brittle*:
minor code edits broke solver traces

Leo started the Lean project in 2013, aimed at *merging* interactive and automated theorem proving

Focus on *classical logic* from the start, collaboration with Jeremy Avigad (CMU) on math library

# Mathlib: 2.2M+ Lines of Formalized Mathematics

270,000+ formalized theorems by 750+ contributors

*An unprecedented community achievement*

{image "static/images/mathlib-deps.png" (width := "55%")}[Mathlib dependency graph]

# The Liquid Tensor Experiment
In 2020, Peter Scholze posed a formalization challenge

> "I spent much of 2019 obsessed with the proof of this theorem, almost getting crazy over it. I still have some small lingering doubts." — Peter Scholze

Johan Commelin led a team that verified the proof, with only minor corrections

*They verified and simplified it without fully understanding the proof.* Lean was a guide

> "The Lean Proof Assistant was really that: an assistant in navigating through the thick jungle that this proof is." — Peter Scholze

# Lean Is Taking Mathematics by Storm
Six Fields Medalists engaged: Tao, Scholze, Viazovska, Gowers, Hairer, Freedman

- [Carleson's Theorem](https://florisvandoorn.com/carleson//) (completed) — van Doorn
- [Liquid Tensor Experiment](https://www.nature.com/articles/d41586-021-01627-2) (completed) — Commelin
- [Equational Theories Project](https://teorth.github.io/equational_theories/) (completed) — Tao
- [Sphere Packing](https://thefundamentaltheor3m.github.io/Sphere-Packing-Lean/) — Birkbeck, Hariharan, Lee, Ma, Mehta, Viazovska
- [Fermat's Last Theorem](https://leanprover-community.github.io/blog/posts/FLT-announcement/) — Buzzard
- [Inter-Universal Teichmüller Theory](https://aitpm.github.io/slides/Mochizuki.pdf) — Mochizuki

# AI startups

> "Lean has become the *de facto choice for AI-based systems* of mathematical reasoning." — ACM SIGPLAN Programming Languages Software Award 2025

:::attr (style := "margin-top: 3em")
{image "static/images/startup-logos.png"}[Startups using Lean]
:::

# Software Verification

%%%
backgroundColor := "#0073A3"
%%%

_Lean is not only for mathematics._

# SampCert (AWS): Verified Differential Privacy
Differential privacy is the gold standard for privacy-preserving data analysis. Implementing it correctly is *hard*

Mironov's attack exploited floating-point to break DP. Bugs in random number generation have destroyed privacy guarantees in real systems

*SampCert* (Jean-Baptiste Tristan): the first comprehensive, mechanized foundation for executable DP implementations

- *12,000+ lines* of Lean proof
- *Discrete Laplace and Gaussian samplers*, proved correct using Fourier analysis and the Poisson summation formula from Mathlib

# SampCert — Deployed at AWS
*Custom code extractor*: the deployed artifact does not go through the Lean compiler. TCB includes the extractor, not the compiler

Performance: SampCert *outperforms diffprivlib by >2×* for discrete Gaussians

*Deployed in [AWS Clean Rooms Differential Privacy](https://aws.amazon.com/clean-rooms/)*

PLDI 2025: "Verified Foundations for Differential Privacy."

# SymCrypt (Microsoft): Verified Cryptography
{image "static/images/symcrypt-aeneas.png"}[SymCrypt verification with Aeneas]

[SymCrypt](https://www.microsoft.com/en-us/research/blog/rewriting-symcrypt-in-rust-to-modernize-microsofts-cryptographic-library/) — Microsoft's core cryptographic library, rewritten in Rust

*Aeneas* translates safe Rust to pure functional Lean code. The bridge that makes Rust verification in Lean practical

# SymCrypt — Verifying Code as Engineers Write It
They verify the *Rust code as written by software engineers*. No special verification-friendly subset

Code is *evolving*: new optimizations for specific hardware (AVX-512, Arm NEON, …). Proofs adapt to rewrites

> "We are verifying code faster than we can write it." — Son Ho, SymCrypt, Microsoft

# Anneal (Google): Verified Unsafe Rust
{image "static/images/anneal-logo.png"}[Anneal logo]

Google's [zerocopy](https://github.com/google/zerocopy) team building "literate verification" for unsafe Rust using Lean and Aeneas

Unsafe Rust accounts for *~2/3 of vulnerabilities* in the Rust ecosystem. Safety invariants are documented only in prose comments

*Anneal*: developers write Lean specifications directly in Rust doc comments
- `spec` blocks for safe code
- `unsafe(axiom)` blocks for opaque unsafe operations with pre/post conditions
- Type invariants for struct safety properties

*Designed for AI agents.* Antigravity demonstrated authoring unsafe Rust and proving its soundness

# Move Borrow Checker
Ilya Sergey (NUS) formalized and verified the borrow checker of Move (smart contract language) in Lean

*39,000 lines* of mechanized metatheory

Claude (Opus 4.5/4.6) handled proof repair, pattern propagation, routine preservation cases

Human insight still needed for novel proof strategies (e.g., weakening lemmas, inter-procedural reasoning for function calls took two days)

*27 working days. Estimated 5-6 months without AI*

Blog post: [Verifying Move Borrow Checker in Lean: an Experiment in AI-Assisted PL Metatheory](https://proofsandintuitions.net/2026/03/18/move-borrow-checker-lean/)

# CSLib: A Mathlib for Computer Science
[CSLib](https://www.cslib.io/) aims to be a foundation for teaching, research, and new verification efforts, including AI-assisted

{image "static/images/cslib-diagram.png" (width := "90%")}[CSLib: adding to CS foundations]

Steering committee: Clark Barrett (Stanford/Amazon), Swarat Chaudhuri (Deepmind/Austin), Jim Grundy (Amazon), Pushmeet Kohli (Deepmind), Leo de Moura (Lean FRO/Amazon), Fabrizio Montesi (U of Southern Denmark)

# Signal Shot
[Signal Shot](https://www.beneficialaifoundation.org/blog/signal-shot) is a public moonshot to verify the Signal protocol and its Rust implementation using Lean

It is a joint effort of Signal (Rolfe Schmidt), the [Beneficial AI Foundation](https://www.beneficialaifoundation.org/) (Max Tegmark), and the Lean FRO

The pieces:

- Aeneas,

- Mathlib and [CSLib](https://www.cslib.io/),

- Symbolic proof automation (`grind`) and scalable verification generation (`SymM`),

- and AI

# Proof Automation

%%%
backgroundColor := "#0073A3"
%%%

_The "classic AI" part of scaling up program verification._

# Do We Still Need Proof Automation?
> "I thought AI would prove all theorems for us now."

:::hstack

- Tactics are like *game moves*
- Better tactics = shorter proofs
- Better tactics = more powerful AI
- Compact proofs = better training data = better AI provers

{image "static/images/grind-compression.png"}[40 lines replaced by one grind call]

:::

# What Is `grind`?
New proof automation, shipped in Lean 4.22, by Leonardo de Moura and Kim Morrison

A *virtual whiteboard*, inspired by modern SMT solvers

- Writes facts on the board. Merges equivalent terms
- Cooperating engines: *congruence closure*, *E-matching*, *constraint propagation*, *guided case analysis*
- Satellite theory solvers: *cutsat* (linear integer arithmetic), *commutative rings* (Gröbner), *linarith*, *AC*
- *Native to dependent type theory.* No translation to FOL
- Produces ordinary Lean proof terms. *Kernel-checkable*

# VC Generation
A *VC generator* turns code and specifications into proof obligations

Lean-based VC generators:

- *Aeneas* — Rust verification via translation to Lean
- *Velvet* — a Dafny-style verifier built in Lean
- *mvcgen* — Lean's VC generator for monadic programs

*Issue: Verification condition generation with proof assistants has not scaled so far*

Adam Chlipala's group documented this for Rocq. The same story holds in Lean

```lean -show
namespace Eval
abbrev Byte := UInt8
abbrev Word := UInt32

def Word.ofInt (a : Int) : Word :=
  UInt32.ofInt a

def Word.add (a b : Option Word) : Word :=
  match a, b with
  | some a, some b => a+b
  | _, _ => 0

def Word.sub (a b : Option Word) : Word :=
  match a, b with
  | some a, some b => a-b
  | _, _ => 0

theorem Word.add_sub_cancel (v : Word) : Word.sub (some (Word.add (some v) (some v))) (some v) = v := by
  simp [Word.add, Word.sub]

theorem Word.add_zero (x : Word) : Word.add (some x) (some (Word.ofInt 0)) = x := by
  simp [Word.add, Word.ofInt, UInt32.ofInt]

structure PartialMap (A B : Type) where
  fn : A -> Option B

def PartialMap.empty (A B : Type) : PartialMap A B :=
  { fn := fun _ => none }

def PartialMap.get {A B : Type} (m : PartialMap A B) (k : A) : Option B :=
  m.fn k

def PartialMap.put [DecidableEq A] (m : PartialMap A B) (k : A) (v : B) : PartialMap A B :=
  { fn := fun x => if x = k then some v else m.fn x }

def PartialMap.remove [DecidableEq A] (m : PartialMap A B) (k : A) : PartialMap A B :=
  { fn := fun x => if x = k then none else m.fn x }

@[ext] theorem PartialMap.ext (m₁ m₂ : PartialMap A B) (h : ∀ k, m₁.get k = m₂.get k) : m₁ = m₂ := by
  cases m₁; cases m₂; congr; funext; apply h

theorem PartialMap.get_put {A B : Type} [DecidableEq A] (m : PartialMap A B) (k : A) (v : B)
    : (m.put k v).get k = some v := by
  simp [PartialMap.get, PartialMap.put]

theorem PartialMap.get_put_diff {A B : Type} [DecidableEq A] (m : PartialMap A B) (k k' : A) (v : B)
    (h : k ≠ k') : (m.put k' v).get k = m.get k :=
  if_neg h

theorem PartialMap.put_put {A B : Type} [DecidableEq A] (m : PartialMap A B) (k : A) (v1 v2 : B)
    : (m.put k v1).put k v2 = m.put k v2 := by
  ext; grind +splitImp [PartialMap.get_put, PartialMap.get_put_diff]
```

# Kraken (Google): x64 Semantics in Lean
[Kraken](https://github.com/AeneasVerif/kraken) is an x64 model written in Lean

Intended for verifying sequential software that performs computations using common registers and memory

Project started after the [Lean@Google Hackathon](https://sites.google.com/view/lean-at-googl-2025/home) in December 2025

# Andres' Challenge
*[Andres Erbsen](https://andres.systems/)* (Google ISE Formal, Rocq software verification veteran)

Andres distilled the scaling problem into a minimal challenge

A small deeply embedded imperative language

```lean -panel
-- !hide
inductive Binop where
  | add | sub

inductive Expr where
  | literal (v: Int)
  | var (x: String)
  | op (bop : Binop) (e1 e2 : Expr)

-- !end hide
inductive Cmd where
  | skip : Cmd
  | set : String → Expr → Cmd
  | seq : Cmd → Cmd → Cmd
  | input : String → Cmd
  -- .

abbrev Memory       := PartialMap Word Byte
abbrev LocalContext := PartialMap String Word
```

```lean -show
def Binop.interp (op : Binop) (a b : Option Word) : Word :=
  match op with
  | .add => Word.add a b
  | .sub => Word.sub a b

theorem Binop.interp_add (w1 w2 : Option Word) : Binop.interp .add w1 w2 = Word.add w1 w2 :=
  rfl

theorem Binop.interp_sub (w1 w2 : Option Word) : Binop.interp .sub w1 w2 = Word.sub w1 w2 :=
  rfl

def Expr.eval (me : Memory) (le : LocalContext) (e : Expr) : Option Word :=
  match e with
  | .literal v    => some (Word.ofInt v)
  | .var x        => le.get x
  | .op bop e1 e2 => some (bop.interp (e1.eval me le) (e2.eval me le))
```

# Andres' Challenge — Operational Semantics
```lean -panel
inductive IOEvent
  | IN : Word → IOEvent
  | OUT : Word → IOEvent

abbrev Post := List IOEvent → Memory → LocalContext → Prop

inductive Exec : Cmd → List IOEvent → Memory → LocalContext → Post → Prop
  | skip  : post es m l → Exec .skip es m l post
  | seq   : Exec c1 es m l mid →
            (∀ es' m' l', mid es' m' l' → Exec c2 es' m' l' post) →
            Exec (.seq c1 c2) es m l post
  | set   : (h_eval : Expr.eval m l e = some v) →
            (h_post : post es m (PartialMap.put l x v)) →
            Exec (.set x e) es m l post
  | input : (∀ v, post (IOEvent.IN v :: es) m (PartialMap.put l x v)) →
            Exec (.input x) es m l post
-- .

theorem Exec.seq_cps (c1 c2 : Cmd) (es : List IOEvent)
    (m : Memory) (l : LocalContext) (post : Post)
    : Exec c1 es m l (fun es' m' l' => Exec c2 es' m' l' post) →
      Exec (.seq c1 c2) es m l post := by
  intro h; apply Exec.seq; apply h; intros; assumption
```

# Andres' Challenge — A Parametric Program
```lean -show
def repeated_cmds (n : Nat) (t x : String) : Cmd :=
  match n with
  | 0 => .skip
  | n + 1 =>
    .seq (.set t (.op .add (.var t) (.var t)))
         (.seq (.set t (.op .sub (.var t) (.var x)))
               (repeated_cmds n t x))

macro "simp_vc" : tactic =>
`(tactic| ( simp only [Expr.eval]; simp only [PartialMap.get_put_diff, PartialMap.get_put, PartialMap.put_put, Binop.interp_add,
          Binop.interp_sub, Word.add_sub_cancel, Option.some.injEq, not_false_eq_true, String.reduceEq, ne_eq]; ))
```

```lean -panel
notation:130 a " ;;\n" b => Cmd.seq a b
notation:150 x " ::= " e:150 => Cmd.set x e
notation:160 a " +' " b:160 => Expr.op Binop.add (Expr.var a) (Expr.var b)
notation:160 a " -' " b:160 => Expr.op Binop.sub (Expr.var a) (Expr.var b)

/-
Generates a command sequence of the form
input b
a := b
a := a + a; a := a - b
..
a := a + a; a := a - b
-/
def generated_cmd (n : Nat) (a b : String) : Cmd :=
  .input b ;;
  a ::= .var b ;;
  repeated_cmds n a b

abbrev spec (m : Memory) : Post := fun es m' l =>
  m' = m ∧ ∃ v : Word, es = [IOEvent.IN v] ∧ l.get "a" = some v

def Goal (n : Nat) : Prop :=
  ∀ m l, Exec (generated_cmd n "a" "b") [] m l (spec m)
```

# Andres' Challenge — Baseline
```lean -panel
example : Goal 1 := by
  intro m l; simp only [generated_cmd, repeated_cmds]; unfold spec
  apply Exec.seq_cps; apply Exec.input; intro v
  apply Exec.seq_cps; apply Exec.set; simp_vc; rfl
  apply Exec.seq_cps; apply Exec.set; simp_vc; rfl
  apply Exec.seq_cps; apply Exec.set; simp_vc; rfl
  apply Exec.skip
  simp only [List.cons.injEq, IOEvent.IN.injEq, and_true, PartialMap.put_put,
    PartialMap.get_put, Option.some.injEq, and_self, exists_eq']
```

With Lean's default tactic framework, `MetaM`, this is *superlinear*

{image "static/images/andres-scaling.svg" (height := "32vh")}[Andres' Challenge tactics time by goal size]

# What Must Be Fast in VC Generation

The recipe is the same independent of the specific generator:

- Efficient `apply`
- Preserve term sharing
- Reuse `simp`/`grind` data across VCs and across simulation steps
- ...

# SymM: Making Verification Scale
- `SymM`: new monadic framework for high-performance software verification. Born after the [Lean@Google Hackathon](https://hackmd.io/sjPWIMP9TIuKW5tuWUfxXA)
- Designed for tools like Aeneas, mvcgen and Velvet that need to _discharge thousands of verification conditions efficiently_

*Without this, verifying something as large as Signal would be too slow and painful*

:::hstack

{image "static/images/symm-benchmark.png"}[SymM vs MetaM benchmark]

{image "static/images/symm-cache-reuse.png"}[SymM with cache reuse]

:::

# mvcgen — Ported to `SymM`

Andres' challenge using Lean monadic code. *Linear* out to n=1000

:::hstack
{image "static/images/mvcgen-tactic.svg" (height := "42vh")}[Tactic time]

{image "static/images/mvcgen-kernel.svg" (height := "42vh")}[Kernel time]
:::

# Velvet — Ported to `SymM`
A Dafny-style verifier in Lean. Ported to `SymM` by *[Vova](https://volodeyka.github.io/)* (Lean FRO intern). Preliminary results

- *Before*: Velvet ran ~3× slower than Dafny
- *After*: Faster than Dafny on 24 of 27 benchmarks; competitive on the other 3

*One port beat Dafny on 24 of 27. Dafny has a vast TCB*

{image "static/images/velvet-benchmark.png" (height := "45vh")}[Dafny vs Velvet vs Velvet + Loom2 verification time]

# The Lean Focused Research Organization (FRO)

Launched in *August 2023* by Leonardo de Moura and me as a non-profit

A nonprofit employing *20 engineers* producing open-source software

[Public roadmap](https://lean-lang.org/fro/roadmap/y3/) | [Our team](https://lean-lang.org/fro/team/)

# Conclusion

ITP-based verification provides highest assurances, in mathematics as in industry

:::attr (style := "margin-top: 1.5em")
"Generative AI" is not enough, "classical" AI and general scalability is as important
:::

:::attr (style := "margin-top: 1.5em")
Program verification can require foundational framework changes to scale
:::

# Thank You

%%%
backgroundColor := "#0073A3"
%%%

lean-lang.org | leanprover.zulipchat.com
