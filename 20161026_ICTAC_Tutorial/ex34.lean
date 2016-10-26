/- Disjunction -/

/- Introduction -/

variables p q : Prop

example (hp : p) : p ∨ q := or.intro_left q hp
example (hq : q) : p ∨ q := or.intro_right p hq

example (hp : p) : p ∨ q := or.inl hp
example (hq : q) : p ∨ q := or.inr hq

/- Elimination

   The or-elimination rule is slightly more complicated.
   The idea is that we can prove r from p ∨ q, by showing that
   1- r follows from p and
   2- r follows from q.

   In other words, it is a proof "by cases." -/

example (h : p ∨ q) : q ∨ p :=
or.elim h
  (assume hp : p,
    show q ∨ p, from or.intro_right q hp)
  (assume hq : q,
    show q ∨ p, from or.intro_left p hq)

example (h : p ∨ q) : q ∨ p :=
or.elim h
  (λ hp, or.inr hp)
  (λ hq, or.inl hq)

example (h : p ∨ q) : q ∨ p :=
h^.elim
  (λ hp, or.inr hp)
  (λ hq, or.inl hq)
