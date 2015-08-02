import data.nat
import theories.number_theory.primes

open nat

eval if (∀ x, x < 10 → x ≠ 5) then 1 else 2

eval is_true (prime 5)

eval is_true (prime 6)

definition f (a : nat) (b : nat) :=
if (∀ x, x < a → x ≠ b ∧ x < 10) then 1 else 2

set_option pp.implicit true
print f
