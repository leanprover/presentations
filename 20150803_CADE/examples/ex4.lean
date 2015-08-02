inductive tree (A : Type) :=
| leaf : A → tree A
| node : tree A → tree A → tree A

check @tree.rec_on
check @tree.induction_on
check @tree.no_confusion
check @tree.cases_on
check @tree.below
check @tree.brec_on

open tree

example (A : Type) (a : A) (t₁ t₂ : tree A) : leaf a ≠ node t₁ t₂ :=
λ h, tree.no_confusion h

example (A : Type) (a₁ a₂ : A) : leaf a₁ = leaf a₂ → a₁ = a₂ :=
λ h, tree.no_confusion h (λ e, e)

example (A : Type) (t₁ t₂ t₃ t₄ : tree A) : node t₁ t₂ = node t₃ t₄ → t₂ = t₄ :=
λ h, tree.no_confusion h (λ e₁ e₂, e₂)
