constants A B C : Type
constant f : A → B
constant g : B → C
constant b : B

check λ x : A, x        -- A → A
check λ x : A, b        -- A → B
check λ x : A, g (f x)  -- A → C
check λ x, g (f x)

-- we can abstract any of the constants in the previous definitions

check λ b : B, λ x : A, x     -- B → A → A
check λ (b : B) (x : A), x    -- equivalent to the previous line
check λ (g : B → C) (f : A → B) (x : A), g (f x)
                              -- (B → C) → (A → B) → A → C
-- we can even abstract over the type

check λ (A B : Type) (b : B) (x : A), x
check λ (A B C : Type) (g : B → C) (f : A → B) (x : A), g (f x)
