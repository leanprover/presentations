check let y := 2 + 2 in y * y   -- ℕ
eval  let y := 2 + 2 in y * y   -- 16

def t (x : ℕ) : ℕ :=
let y := x + x in y * y

eval t 2   -- 16
