import data.vector
open nat vector

check λ x, x + 1

check vector bool 10

check [1, 2, 3]

check [(1:nat), 2, 3]

check nat → nat

check Π (k : nat), vector bool k

check λ (n : nat) (v : vector nat n), cons 0 v

definition id₁ (A : Type) (a : A) : A :=
a

definition id₂.{u} (A : Type.{u}) (a : A) : A :=
a

set_option pp.universes true
check id₁
check id₂
