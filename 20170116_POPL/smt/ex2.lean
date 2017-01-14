universe variables u
variable {α : Type u}

def app : list α → list α → list α
| []     l := l
| (h::t) l := h :: app t l

/- Add all equational lemmas for app into the [ematch] lemma set -/
attribute [ematch] app

@[ematch] lemma app_nil_right (l : list α) : app l [] = l :=
begin [smt]
  induction l,
  /- Jump to eblast definition. -/
  eblast,
end

/- We can trace the E-matching procedure. -/
set_option trace.smt.ematch true

@[ematch] lemma app_assoc (l₁ l₂ l₃ : list α) : app (app l₁ l₂) l₃ = app l₁ (app l₂ l₃) :=
begin [smt]
  induction l₁,
  all_goals {eblast},
end

def len : list α → nat
| []       := 0
| (a :: l) := len l + 1

attribute [ematch] len

lemma len_app (l₁ l₂ : list α) : len (app l₁ l₂) = len l₁ + len l₂ :=
begin [smt]
  induction l₁,
  all_goals {eblast},
end

set_option trace.smt.ematch false

/- We now define a new interactive tactic that implements the recurrent pattern above. -/
open interactive.types
namespace smt_tactic.interactive
  meta def iblast (v : qexpr0) : smt_tactic unit :=
  induction v none [] >> all_goals eblast
end smt_tactic.interactive

example (l₁ l₂ : list α) : len (app l₁ l₂) = len l₁ + len l₂ :=
begin [smt] iblast l₁ end

/- We can also pack it as a regular interactive tactic -/
namespace tactic.interactive
  meta def iblast (v : qexpr0) : tactic unit :=
  using_smt $ smt_tactic.interactive.iblast v
end tactic.interactive

example (l₁ l₂ : list α) : len (app l₁ l₂) = len l₁ + len l₂ :=
by iblast l₁

/-
We can define our own attributes for storing E-matching lemmas.

The command mk_hinst_lemma_attr_set is implemented in Lean.
-/
run_command mk_hinst_lemma_attr_set `myhset [] []

meta def my_cfg : smt_config :=
{ default_smt_config with em_attr := `myhset }

constant f : nat → nat
axiom fax  : ∀ x, f (f x) = f x

attribute [myhset] fax

example (a b : nat) : a = b → f (f (f (f (f a)))) = f (f b) :=
begin [smt] with my_cfg,
  intros,
  eblast
end
