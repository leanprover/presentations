import tools.super

-- The super tactic takes two lists of lemmas as arguments:
--   super [normal lemmas] with [sos lemmas]

-- The sos lemmas ("set of support") are only used in a restricted way: we do
-- not perform inferences between sos lemmas, just with other clauses. (For
-- performance reasons.)

-- If the formula is valid in first-order logic (without extra lemmas), then
-- just `super` is enough:
example (a b c : Prop) : (a → b → c) ↔ (¬(¬c ∧ a) ∨ ¬b) := by super
example (p : ℕ → Prop) (r : Prop) : (∃ x, p x → r) ↔ (∀ x, p x) → r := by super

-- You can see what clauses super infers by enabling the trace.super option:
set_option trace.super true
example (p q : ℕ → Prop) : p 3 → (∀x, p x → q x^.succ) → q (nat.succ 3) :=
by super
-- (Can we make this work with 4 instead of (nat.succ 3) as well?)

-- External lemmas can be included by their full name after super:
example {α a} {s t : list α} : a ∉ s → a ∈ s ++ t → a ∈ t :=
by super list.mem_append_iff
-- (You can also try putting `with` here.)

-- super makes it very easy to obtain slight variations of lemmas in the library:
example {α a} {s t : list α} : a ∉ s → a ∉ t → a ∉ s ++ t := by super list.mem_append_iff
example {α a} {s t : list α} : a ∈ s ∨ a ∈ t ∨ a ∉ t ++ s := by super list.mem_append_iff
example {α a b} {t : list α} : a = b ∨ a ∈ t ∨ a ∉ t ++ [b] ++ t := by super list.mem_append_iff
