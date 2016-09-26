import data.vector theories.number_theory.primes
open bool nat list vector

check nat
check list

check fact 3

eval fact 5

check λ x, x + 1

check λ (n : nat) (v : vector nat n), 0::v

check add

print prime

eval is_true (prime 7)
eval is_true (prime 4)

set_option pp.universes true

check Type.{5}
