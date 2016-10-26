/- And ~ Product/Pair -/

example (p q : Prop) : p ∧ q → q ∧ p :=
assume ⟨hp, hq⟩, ⟨hq, hp⟩

example (A B : Type) : A × B → B × A :=
assume ⟨a, b⟩, ⟨b, a⟩

/- Or ~ Sum/Union Type -/

example (p q : Prop) (h : p ∨ q) : q ∨ p :=
match h with
| or.inl h := or.inr h
| or.inr h := or.inl h
end

example (A B : Type) (s : sum A B) : sum B A :=
match s with
| sum.inl h := sum.inr h
| sum.inr h := sum.inl h
end
