import tools.super

-- super can prove statements about associative-commutative function symbols,
-- if we tell it to use the right lemmas:
example (x y z w : ℕ) : x + y + z + w = (w + z) + (y + x) :=
by super nat.add_assoc nat.add_comm
-- (Internally, this works in a very similar way to the sorting by rewriting
-- described in `../assoc/ac_by_simp.lean`.)

-- We can also prove existential statements using super:
example (x y z w : ℕ) : ∃a, x + y + z + w = a + (y + x) :=
by super with nat.add_assoc nat.add_comm

-- This support also works with other types than ℕ.
-- Let us show the well-known fact that if a monoid has right inverses, they are
-- also left inverses (i.e., it is a group):
example {α} [monoid α] [has_inv α]
            (right_inverse : ∀x : α, x   * x⁻¹ = 1) :
                             ∀x : α, x⁻¹ * x   = 1 :=
by super with monoid.mul_assoc monoid.mul_one
