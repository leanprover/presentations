import tools.auto.finish

constant α : Type
constants (p q : α → Prop)

example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a) :=
λ h, exists.elim h (λ a ha, and.intro
  (exists.intro a (and.left ha))
  (exists.intro a (and.right ha)))

-- dot-notation shorthand
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a) :=
λ h, exists.elim h (λ a ha, and.intro
  (exists.intro a ha.left)
  (exists.intro a ha.right))

-- Isar-like
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a) :=
assume h,
exists.elim h
  (take a,
   suppose p a ∧ q a,
   show (∃ a, p a) ∧ (∃ a, q a), from
     and.intro (exists.intro a this.left) (exists.intro a this.right))

-- pattern matching
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a)
| (exists.intro a (and.intro hp hq)) := and.intro (exists.intro a hp) (exists.intro a hq)

-- anonymous constructor notation
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a)
| ⟨a, ⟨hp, hq⟩⟩ := ⟨⟨a, hp⟩, ⟨a, hq⟩⟩

-- tactic proof
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a) :=
begin
  intro h,
  cases h with a h,
  cases h with hp hq,
  constructor,
  { constructor, apply hp },
  { constructor, apply hq },
end

-- finish
example : (∃ a, p a ∧ q a) → (∃ a, p a) ∧ (∃ a, q a) :=
by finish
