import tools.super

-- This is the same example we used for ematching.  (see ???)

constant heap   : Type
constant ptr    : Type
constant val    : Type
constant pt     : ptr → val → heap
constant hunion : heap → heap → heap
constant is_def : heap → Prop

infix ` ∙ `:60 := hunion
infix `↣`:70 := pt

axiom hcomm    : ∀ x y, x ∙ y = y ∙ x
axiom hassoc   : ∀ x y z, (x ∙ y) ∙ z = x ∙ (y ∙ z)

-- The development is very similar, except that I simplified the hnoalias
-- assumption a bit from previously: is_def (h ⬝ y₁↣w₁ ⬝ y₂↣w₂) → y₁ ≠ y₂
axiom hnoalias : ∀ h y w₁ w₂, ¬is_def (h ∙ y ↣ w₁ ∙ y ↣ w₂)

-- (Usually superposition provers do this simplification automatically, but it's
-- not implemented in super yet.)

set_option trace.super true
lemma ex (h₁ h₂ : heap) (x₁ x₂ x₃ x₄ : ptr) (v₁ v₂ v₃ : val)
: is_def (h₁ ∙ (x₁ ↣ v₁ ∙ x₂ ↣ v₂) ∙ h₂ ∙ (x₃ ↣ v₃)) → x₁ ≠ x₃ ∧ x₁ ≠ x₂ ∧ x₂ ≠ x₃ :=
by super hnoalias with hassoc hcomm
