variables p q : Prop

check p → q → p ∧ q
check p -> q -> p /\ q

check ¬p → p ↔ false
check not p -> p <-> false

check p ∨ q → q ∨ p
check p \/ q → q \/ p
