import algebra.ring
open algebra

variable {A : Type}

check @add.left_cancel

abbreviation lcancel {A : Type} [r : ring A] (a : A) {b c : A} : a + b = a + c → b = c :=
assume H, add.left_cancel H
abbreviation addz := @add_zero
abbreviation ldist := @left_distrib

theorem mul_zero [s : ring A] (a : A) : a * 0 = 0 :=
lcancel (a*0) (by rewrite [-ldist, *addz])
