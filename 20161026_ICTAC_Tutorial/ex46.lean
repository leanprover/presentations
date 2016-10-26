/- Calculational environment -/

variables (a b c d e : ℕ)
variable h1 : a = b
variable h2 : b = c + 1
variable h3 : c = d
variable h4 : e = 1 + d

include h3

example : a = e :=
calc
  a     = b      : h1
    ... = c + 1  : h2
    ... = d + 1  : by rewrite h3
    ... = 1 + d  : nat.add_comm d 1
    ... = e      : eq.symm h4
