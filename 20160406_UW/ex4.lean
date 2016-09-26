import data.nat theories.number_theory.primes
open nat subtype

eval is_true (∀ x, x < 5 → ∃ y, y < x ∧ y*y = x)

-- definition sub_dvd_of_not_prime {n : nat} : n ≥ 2 → ¬ prime n → {m : nat | m ∣ n ∧ m ≠ 1 ∧ m ≠ n} :=

eval elt_of (@sub_dvd_of_not_prime 10 dec_trivial dec_trivial)

check ex_dvd_of_not_prime
