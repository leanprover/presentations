/- Applications -/
constants A B C : Type
constant f : A → B
constant g : B → C
constant h : A → A
constants (a : A) (b : B)

check (λ x : A, x) a                -- A
check (λ x : A, b) a                -- B
check (λ x : A, b) (h a)            -- B
check (λ x : A, g (f x)) (h (h a))  -- C

check (λ (v : B → C) (u : A → B) x, v (u x)) g f a   -- C

check (λ (Q R S : Type) (v : R → S) (u : Q → R) (x : Q),
        v (u x)) A B C g f a        -- C
