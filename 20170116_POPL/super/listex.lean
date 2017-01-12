import tools.super
open list

-- These are the same examples we used to show backchaining.  (see backchaining directory)

-- Backchaining is a special case of resolution, so we can solve them using
-- super as well.

set_option trace.super true

-- The first few cases can be handled by super's built-in support for data types
-- and definition unfolding:
-- when super sees a clause [a ∉ b :: bs], it will derive [a ≠ b] and [a ∉ bs].

example (a b c : nat) : a ∈ [b, c] ++ [b, a, b] :=
by super

example (a b c : nat) : a ∈ [b, c] ++ [b, c, c] ++ [b, a, b] :=
by super

example (a b c : nat) (l : list nat) : a ∈ l → a ∈ [b, c] ++ b::l :=
by super

-- However super doesn't know anything about append, so it cannot figure out
-- that append preserves membership:
example (x : nat) (xs ys : list nat) : x ∈ xs → x ∈ xs ++ ys :=
by super

-- So we need to tell super about append. (We also need to give it a few lemmas
-- about membership and cons, otherwise it gets lost.)

universe variable u
lemma in_tail  {α : Type u} {a : α} (b : α) {l : list α}      : a ∈ l → a ∈ b::l   := mem_cons_of_mem _
lemma in_head  {α : Type u} (a : α) (l : list α)              : a ∈ a::l           := mem_cons_self _ _
lemma in_left  {α : Type u} {a : α} {l : list α} (r : list α) : a ∈ l → a ∈ l ++ r := mem_append_left _
lemma in_right {α : Type u} {a : α} (l : list α) {r : list α} : a ∈ r → a ∈ l ++ r := mem_append_right _

example (a b c : nat) (l₁ l₂ : list nat) : a ∈ l₁ → a ∈ b::b::c::l₂ ++ b::c::l₁ ++ [c, c, b] :=
by super with in_left in_right in_head in_tail
