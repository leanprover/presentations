variables p q r s : Prop

theorem t2 : (q → r) → (p → q) → p → r :=
assume h1 : q → r,
assume h2 : p → q,
assume h3 : p,
show r, from h1 (h2 h3)

theorem t2' : (q → r) → (p → q) → p → r :=
λ (h1 : q → r) (h2 : p → q) (h3 : p), h1 (h2 h3)

theorem t2'' (h1 : q → r) (h2 : p → q) (h3 : p) : r :=
h1 (h2 h3)
