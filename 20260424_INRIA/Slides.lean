import VersoSlides
import Diagrams

open VersoSlides

#doc (Slides) "INRIA 2026" =>
%%%
theme := "white"
slideNumber := true
transition := "none"
%%%

# A deep dive into Lean's processing pipeline

Sebastian Ullrich, Lean FRO

INRIA, April 24, 2026

# Layers of processing

* *file level*: Lake, module system
* *declaration level*: incremental parsing & elaboration, parallelism
* *tactic level*: incremental execution

# File level

```animate (background := "#ffffff")
INRIA.ModuleDiagram.buildAnim
```

Make-like separate, parallel processing

Can build Mathlib's 9k+ files in 9min30s at 2300% CPU on an AMD EPYC 9455

# Lakeprof

{image "lakeprof.png" (class := "img-tall")}[lakeprof]

# File level

```animate (background := "#ffffff")
INRIA.ModuleDiagram.rebuildAnim
```

*Module system*: consistently separating private and public data to allow for _rebuild avoidance_

# File level

{image "modulize.gif" (class := "img-tall")}[modulize]

# Module system basics

Opt-in via `module` header keyword

* Declarations _and imports_ now `private` by default; adjust using `public`
* `def` bodies are also private to the module unless `@[expose]`d
* Proofs are always private
* All metaprograms need to be annotated/imported with `meta`

=> Much more precise control over what information a module exposes

More info: Reference Manual §5.4+, Lean Hackathon keynote #2, Lean Together 2026 talk

# Basic module system optimizations

* Rebuild avoidance: changes to private data stop at the end of the file; public changes at the next `import`
* 64% of mathlib4 data is private; RAM use of `import Mathlib` reduced by 48%
* TBD: download only necessary parts from cloud cache
* Do not link `meta` code into final executable
* potentially: start downstream builds as soon as public data is ready

Lake is being extended with a _content-addressed_ local/remote cache to allow for cache hits even when transitive inputs are not identical

# Module system: implementation (difficulties)

Primary goals: no kernel changes, minimize metaprogramming API changes

```leanModule -panel
-- !hide
import Lean.Environment
open Lean

namespace Demo
-- !end hide
public structure Kernel.Environment where
  ...

structure VisibilityMap (α : Type) where
  «private» : α
  «public»  : α

public structure Environment where
  isExporting  : Bool
  private base : VisibilityMap Kernel.Environment
  /- !replace ... -//- !end replace -/

def Environment.find? (env : Environment) (n : Name) : Option ConstantInfo :=
  if env.isExporting then /- !replace ... -/none else none/- !end replace -/
```

_Environment extensions_ gained optional callback to separate private from public export data

# In progress: separate compilation

```animate (background := "#ffffff")
INRIA.ModuleDiagram.separateCompAnim
```

The compiler both creates less-stable public data and is only relevant for downstream `meta` code

:::fragment irFade (index := 0)
=> move to separate build step
:::

# Declaration level: parallelism

::::hstack
:::vstack
* Theorem bodies (proofs)
* Kernel checking
* Linting
* (Meta) compilation

Diagnostics are collected in an asynchronously growing tree

Cmdline reports pre-order traversal of tree, language server unordered traversal
:::

{image "parallel.gif"}[parallelism]
::::

# Parallelism: implementation (difficulties)

```leanModule -panel
-- !hide
module
public import Lean.Environment
import all Lean.Environment
open Lean

namespace Demo
-- !end hide
structure AsyncConstantInfo where
  name      : Name
  kind      : ConstantKind
  sig       : Task ConstantVal
  constInfo : Task ConstantInfo

public structure Environment where
  /- !replace ... -//- !end replace -/
  checked                : Task Kernel.Environment
  -- (simplified)
  private asyncConstsMap : VisibilityMap (NameMap AsyncConstantInfo)
  /- !replace ... -//- !end replace -/

def Environment.findTask (env : Environment) (n : Name) : Task (Option AsyncConstantInfo)
def Environment.findConstVal? (env : Environment) (n : Name) : Option ConstantVal
def Environment.find? (env : Environment) (n : Name) : Option ConstantInfo
```

Environment extensions again add extra (back-compat) complexity, now come with an `asyncMode` defaulting to "main thread only".

# `trace.profiler`

{image "fxprof.png" (class := "img-tall")}[fxprof]

# Declaration & tactic level: incrementality

::::hstack
:::vstack
Purely syntactic, for now: reuse parser & elaborator results strictly above change

Tactic combinators can opt into nested incrementality support

In progress: also allow saving this data to disk
:::

{image "incremental.gif"}[incrementality]
::::

# Thank You

Questions?
