import data.prod
open nat prod
universe l
open inhabited
print instances inhabited

eval default (nat → nat × Prop × nat)





definition add (x y : nat) : nat :=
nat.rec x (λ n r, succ r) y

abbreviation s := succ
abbreviation z := zero
abbreviation f := λ n r : nat, succ r

check calc
  add (s z) (s (s z)) = nat.rec (s z) f (s (s z)) : rfl
                ...   = s (nat.rec (s z) f (s z)) : rfl
                ...   = s (s (nat.rec (s z) f z)) : rfl
                ...   = s (s (s z))               : rfl
