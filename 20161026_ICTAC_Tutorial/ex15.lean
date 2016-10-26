/-
 We want to do is define objects in Lean and prove things about them.
-/

definition foo : (ℕ → ℕ) → ℕ := λ f, f 0

check foo    -- (ℕ → ℕ) → ℕ
print foo    -- λ (f : ℕ → ℕ), f 0

eval foo nat.succ

definition foo' := λ f : ℕ → ℕ, f 0

check foo'
