open classical

variables p q : Prop

check em p

theorem dne {p : Prop} (h : ¬¬p) : p :=
or.elim (em p)
  (assume hp : p, hp)
  (assume hnp : ¬p, absurd hnp h)

/- For a constructivist ¬¬p means "p is non-contradictory" -/

example (h : ¬¬p) : p :=
by_cases
  (assume h1 : p, h1)
  (assume h1 : ¬p, absurd h1 h)

example (h : ¬¬p) : p :=
by_contradiction
  (assume h1 : ¬p,
    show false, from h h1)

example (h : ¬ (p ∧ q)) : ¬ p ∨ ¬ q :=
or.elim (em p)
  (assume hp : p,
    have hnq : ¬q, from
      assume hq : q, h ⟨hp, hq⟩,
    or.inr hnq)
  (assume hp : ¬p,
    or.inl hp)
