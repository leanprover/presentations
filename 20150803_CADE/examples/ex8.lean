import data.nat
open nat

theorem add_comm (x y : ℕ) : x + y = y + x :=
begin
  induction x with x ih,
    show 0 + y = y + 0, by rewrite zero_add,
    show succ x + y = y + succ x,
      begin
        cases y with y,
          {rewrite zero_add},
          {rewrite [succ_add, ih]}
      end
end

variables a b c d : nat
example (Ha : a = b + c) (Hd : d = b) : a + d = b + c + d :=
by substvars

variables p q : Prop
example (Hp : p) (Hq : q) : p ∧ q :=
begin split, repeat assumption end
