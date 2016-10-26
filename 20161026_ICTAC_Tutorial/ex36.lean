/- Logical equivalence -/

print iff

variables p q : Prop

theorem and_swap : p ∧ q ↔ q ∧ p :=
iff.intro
  (assume h : p ∧ q,
    show q ∧ p, from and.intro (and.right h) (and.left h))
  (assume h : q ∧ p,
    show p ∧ q, from and.intro (and.right h) (and.left h))


check and_swap p q    -- p ∧ q ↔ q ∧ p

premise h : p ∧ q
example : q ∧ p := iff.mp (and_swap p q) h

example : q ∧ p := (and_swap p q)^.mp h

check and_swap q p    -- q ∧ p ↔ p ∧ q

example : q ∧ p := iff.mpr (and_swap q p) h
