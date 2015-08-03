import data.nat
open nat

check ∀ (x : nat), x > 0

premise h : ∀ (x : nat), x > 0
check h 1
check h 0

theorem my_first_thm (a b : Prop) : a → b → a :=
λ (h₁ : a) (h₂ : b), h₁

check my_first_thm

-- reveal my_first_thm

print my_first_thm

definition id {A : Type} (a : A) : A := a

-- set_option pp.implicit true

check id 10

-- Proof irrelevance

theorem pr_irrel (p : Prop) (h₁ : p) (h₂ : p) : h₁ = h₂ :=
rfl

check pr_irrel

open subtype
definition nsub := {a : nat | a < 10 ∨ even a}

definition a : nsub := tag 2 (or.inl dec_trivial)

definition b : nsub := tag 2 (or.inr dec_trivial)

example : a = b :=
rfl
