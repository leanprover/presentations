check eq.refl    -- ∀ (a : ?M_1), a = a
check eq.symm    -- ?M_2 = ?M_3 → ?M_3 = ?M_2
check eq.trans   -- ?M_2 = ?M_3 → ?M_3 = ?M_4 → ?M_2 = ?M_4

variables (A : Type) (a b c d : A)
premises (hab : a = b) (hcb : c = b) (hcd : c = d)

example : a = d :=
eq.trans (eq.trans hab (eq.symm hcb)) hcd

example : a = d :=
(hab^.trans hcb^.symm)^.trans hcd
