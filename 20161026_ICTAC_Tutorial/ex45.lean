/- Leibniz equality

   Replacing equals with equals. -/

example (A : Type) (a b : A) (P : A → Prop) (h1 : a = b) (h2 : P a) : P b :=
eq.subst h1 h2

example (A : Type) (a b : A) (P : A → Prop) (h1 : a = b) (h2 : P a) : P b :=
h1 ▸ h2
