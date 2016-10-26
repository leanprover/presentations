variables (A : Type) (p q : A → Prop)

example (h : ∃ x, p x ∧ q x) : ∃ x, q x ∧ p x :=
exists.elim h
  (take w,
   assume hw : p w ∧ q w,
   show ∃ x, q x ∧ p x, from ⟨w, hw^.right, hw^.left⟩)

example (h : ∃ x, p x ∧ q x) : ∃ x, q x ∧ p x :=
match h with
| ⟨w, hw⟩ := ⟨w, hw^.right, hw^.left⟩
end

example (h : ∃ x, p x ∧ q x) : ∃ x, q x ∧ p x :=
match h with
| ⟨w, hpw, hqw⟩ := ⟨w, hqw, hpw⟩
end

example : (∃ x, p x ∧ q x) → ∃ x, q x ∧ p x :=
assume ⟨w, hpw, hqw⟩, ⟨w, hqw, hpw⟩
