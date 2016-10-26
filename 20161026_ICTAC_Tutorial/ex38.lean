variables p q r : Prop

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
iff.intro
  (assume h : p ∧ (q ∨ r),
    have hp : p, from h^.left,
    or.elim (h^.right)
      (assume hq : q,
        show (p ∧ q) ∨ (p ∧ r), from or.inl ⟨hp, hq⟩)
      (assume hr : r,
        show (p ∧ q) ∨ (p ∧ r), from or.inr ⟨hp, hr⟩))
  (assume h : (p ∧ q) ∨ (p ∧ r),
    or.elim h
      (assume hpq : p ∧ q,
        have hp : p, from hpq^.left,
        have hq : q, from hpq^.right,
        show p ∧ (q ∨ r), from ⟨hp, or.inl hq⟩)
      (assume hpr : p ∧ r,
        have hp : p, from hpr^.left,
        have hr : r, from hpr^.right,
        show p ∧ (q ∨ r), from ⟨hp, or.inr hr⟩))

example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
iff.intro
  (λ h, or.elim (h^.right)
      (λ hq, or.inl ⟨h^.left, hq⟩)
      (λ hr, or.inr ⟨h^.left, hr⟩))
  (λ h, or.elim h
      (λ hpq, ⟨hpq^.left, or.inl hpq^.right⟩)
      (λ hpr, ⟨hpr^.left, or.inr hpr^.right⟩))
