/- Reflexivity is more powerful than it looks -/

variables (A B : Type)

example (f : A → B) (a : A) : (λ x, f x) a = f a := eq.refl _
example (a : A) (b : A) : (a, b).1 = a := eq.refl _
example : 2 + 3 = 5 := eq.refl _
