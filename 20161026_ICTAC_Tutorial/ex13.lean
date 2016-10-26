/- Beta reduction -/

constants A B C : Type
constant f : A → B
constant g : B → C
constant h : A → A
constants (a : A) (b : B)

eval (λ x : A, x) a                -- a
eval (λ x : A, b) a                -- b
eval (λ x : A, b) (h a)            -- b
eval (λ x : A, g (f x)) a          -- g (f a)

eval (λ (v : B → C) (u : A → B) x, v (u x)) g f a   -- g (f a)

eval (λ (Q R S : Type) (v : R → S) (u : Q → R) (x : Q),
       v (u x)) A B C g f a        -- g (f a)
