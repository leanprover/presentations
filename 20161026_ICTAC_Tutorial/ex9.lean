check fun x : nat, x + 5
check λ x : nat, x + 5

constants A B  : Type
constants a1 a2 : A
constants b1 b2 : B

constant f : A → A
constant g : A → B
constant h : A → B → A
constant p : A → A → bool

check fun x : A, f x                      -- A → A
check λ x : A, f x                        -- A → A
check λ x : A, f (f x)                    -- A → A
check λ x : A, h x b1                     -- A → A
check λ y : B, h a1 y                     -- B → A
check λ x : A, p (f (f x)) (h (f a1) b2)  -- A → bool
check λ x : A, λ y : B, h (f x) y         -- A → B → A
check λ (x : A) (y : B), h (f x) y        -- A → B → A
check λ x y, h (f x) y                    -- A → B → A
