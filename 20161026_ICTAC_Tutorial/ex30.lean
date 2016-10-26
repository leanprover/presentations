theorem t1 (p q : Prop) : p → q → p :=
λ (hp : p) (hq : q), hp

variables p q r s : Prop

check t1 p q                -- p → q → p
check t1 r s                -- r → s → r
check t1 (r → s) (s → r)    -- (r → s) → (s → r) → r → s

variable h : r → s
check t1 (r → s) (s → r) h  -- (s → r) → r → s

premise h' : r → s
check t1 (r → s) (s → r) h'
