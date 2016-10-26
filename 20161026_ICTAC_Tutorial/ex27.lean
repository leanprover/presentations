variables A B : Type
variable a : A
variable b : B

check @id        -- Π {A : Type u_1}, A → A
check @id A      -- A → A
check @id B      -- B → B
check @id A a    -- A
check @id B b    -- B
check id
check id a
