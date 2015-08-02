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
