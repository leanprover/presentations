/-
Lean has a tactic (cc) that performs congruence closure modulo associativity and commutativity.
However, in this unit, we will not focus on it, but on how to implement our own tactics.
In the remaining files in this unit, we will construct a tactic that "flats" nested applications
of associated operators.
-/
import data.set

example (a b c d : nat) : a + b + c + d = c + a + b + d :=
by cc

example (s₁ s₂ s₃ s₄ : set nat) : (s₁ ∪ s₂) ∪ (s₃ ∪ s₄) = s₁ ∪ (s₂ ∪ (s₃ ∪ s₄)) :=
by cc

example {α : Type} (s₁ s₂ s₃ s₄ : set α) : s₁ ∪ s₂ ∪ s₃ ∪ s₄ = (s₄ ∪ s₁) ∪ (s₂ ∪ s₃) :=
by cc

example {α : Type} (s₁ s₂ s₃ s₄ t r : set α) : (t = s₁ ∪ s₂) → (r = s₂ ∪ s₃) → t ∪ s₃ ∪ s₄ = (s₄ ∪ s₁) ∪ r :=
by cc
