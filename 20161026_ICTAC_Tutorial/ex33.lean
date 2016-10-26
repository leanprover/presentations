/- Conjunction -/

/- Introduction -/
variables p q : Prop

example (hp : p) (hq : q) : p ∧ q := and.intro hp hq

check assume (hp : p) (hq : q), and.intro hp hq

/- Elimination -/

example (h : p ∧ q) : p := and.elim_left h
example (h : p ∧ q) : q := and.elim_right h

example (h : p ∧ q) : p := and.left h
example (h : p ∧ q) : q := and.right h

/- Simple lemma -/

example (h : p ∧ q) : q ∧ p :=
and.intro (and.right h) (and.left h)

example (h : p ∧ q) : q ∧ p :=
and.intro h^.right h^.left

premises  (hp : p) (hq : q)
check (⟨hp, hq⟩ : p ∧ q)

example (h : p ∧ q) : q ∧ p :=
⟨h^.right, h^.left⟩

example (h : p ∧ q) : q ∧ p :=
(| h^.right, h^.left |)

example (h : p ∧ q) : q ∧ p ∧ q:=
⟨h^.right, ⟨h^.left, h^.right⟩⟩

example (h : p ∧ q) : q ∧ p ∧ q:=
⟨h^.right, h^.left, h^.right⟩
