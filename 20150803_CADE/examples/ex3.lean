open nat

inductive tree (A : Type) :=
| leaf : A → tree A
| node : tree A → tree A → tree A

check tree.leaf 10
check tree.leaf (10:nat)
open tree
check leaf 10

definition nleaves {A : Type} (t : tree A) : nat :=
tree.rec (λ a, 1) (λ n₁ n₂ r₁ r₂, r₁ + r₂) t

eval nleaves (node (leaf 10) (node (leaf 20) (leaf 30)))
