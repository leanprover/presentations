/- Auxiliary goals -/

section
  variables p q : Prop

  example (h : p ∧ q) : q ∧ p :=
  have hp : p, from and.left h,
  have hq : q, from and.right h,
  show q ∧ p, from and.intro hq hp

  example (h : p ∧ q) : q ∧ p :=
  have p, from and.left h,
  have q, from and.right h,
  show q ∧ p, from and.intro ‹q› ‹p›

  example (h : p ∧ q) : q ∧ p :=
  have p, from and.left h,
  have q, from and.right h,
  show q ∧ p, from and.intro this ‹p›

  example (h : p ∧ q) : q ∧ p :=
  have hp : p, from and.left h,
  have q, from and.right h,
  show q ∧ p, from and.intro this hp

end
