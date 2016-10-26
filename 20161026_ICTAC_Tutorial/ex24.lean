/- Σ x : A, B x -/

variable A : Type
variable B : A → Type
variable a : A
variable b : B a

check sigma.mk a b   -- Σ (a : A), B a
check (sigma.mk a b).1  -- A
check (sigma.mk a b).2  -- B (sigma.fst (sigma.mk a b))

eval  (sigma.mk a b).1  -- a
eval  (sigma.mk a b).2  -- b

eval sigma.fst (sigma.mk a b)
eval sigma.snd (sigma.mk a b)
