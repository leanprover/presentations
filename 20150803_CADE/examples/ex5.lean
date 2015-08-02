open nat

inductive list (A : Type) :=
| nil {} : list A
| cons   : A → list A → list A

open list

infixr `::` := cons

check 1 :: 2 :: nil

variable {A : Type}

definition append : list A → list A → list A
| nil     ys := ys
| (x::xs) ys := x :: append xs ys

infix `++` := append

eval (1::nil) ++ (2::3::nil)

theorem nil_append (l : list A) : nil ++ l = l :=
rfl

theorem append_nil : ∀ (l : list A), l ++ nil = l
| nil     := rfl
| (x::xs) := calc
    x::xs ++ nil = x :: (xs ++ nil) : rfl
        ...      = x :: xs          : append_nil

check append_nil (2::3::nil)
