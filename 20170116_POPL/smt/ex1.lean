universe variable u
variable {α : Type u}
variable [comm_ring α]
variable [f : α → α]
variable [p : α → Prop]

/- Our first example is solved using congruence closure, and
   theory AC. It gets solved as soon as we introduce the hypothesis -/
example (a b c : α) : a = b → p (a + c) → p (c + b) :=
begin [smt]
  intros
end

/- The tactic perform unit propagation without performing CNF conversion,
   and propagate equivalences between propositions. -/
example (p q r : Prop) : p ∧ (q ∨ r) → (p ∧ q) ∨ (p ∧ r) :=
begin [smt]
  intros
end

/- We can case-split using the `destruct` tactic.-/
example (p q : Prop) : (p ∨ q) → (p ∨ ¬q) → (¬p ∨ q) → p ∧ q :=
begin [smt]
  intros h₁ h₂ h₃,
  /- Split (h₁ : p ∨ q) in two cases -/
  destruct h₁
end

/- By default the SMT tactic framework uses classical logic -/
example (p q : Prop) : p ∨ q → p ∨ ¬q → ¬p ∨ q → p ∧ q :=
begin [smt]
   intros,
   /- Split on p ∨ ¬p -/
   by_cases p
end

/- No excluded middle config object -/
meta def no_em_cnf : smt_config :=
default_smt_config^.set_classical ff

example (p q : Prop) : p ∨ q → p ∨ ¬q → ¬p ∨ q → p ∧ q :=
begin [smt] with no_em_cnf,
   intros,
   /- We can only case-split on p ∨ ¬p if p is know to be decidable. -/
   by_cases p -- <<< ERROR
end

/-
The SMT tactic framework relies on semi-constructive axiom: propext and funext.
You should not use it if you want to avoid these axioms.
-/

variables  q : α → α → Prop

/- We can use assert/note/pose/define tactics like we do in regular tactic mode. -/
example (a b c : α)
        (qprop : ∀ {a : α}, q (f a) (f a) → q a a)
        : a = b → q (f a) (f b) → q a b :=
begin [smt]
  intros,
  /- The following tactic adds (h : q (f a) (f a)) to the set of hypotheses.
     Note the new goal is discharged automatically. -/
  assert h : q (f a) (f a),
  note h' := qprop h
end
