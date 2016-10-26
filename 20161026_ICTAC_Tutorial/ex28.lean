namespace hide

/- Prop, to represent propositions,
   and constructors to build new propositions from others. -/

constant and : Prop → Prop → Prop
constant or : Prop → Prop → Prop
constant not : Prop → Prop
constant implies : Prop → Prop → Prop

/- Proof p, for the type of proofs of p -/
constant Proof : Prop → Type

/- "axiom" would be constant of such a type. -/
constant and_comm : Π p q : Prop, Proof (implies (and p q) (and q p))

variables p q : Prop
check and_comm p q      -- Proof (implies (and p q) (and q p))

/- From a proof of implies p q and a proof of p, we obtain a proof of q. -/

constant modus_ponens (p q : Prop) : Proof (implies p q) →  Proof p → Proof q

/-
  Systems of natural deduction for propositional logic also typically
  rely on the following rule:

  Suppose that, assuming p as a hypothesis, we have a proof of q.
  Then we can "cancel" the hypothesis and obtain a proof of implies p q.
-/

constant implies_intro (p q : Prop) : (Proof p → Proof q) → Proof (implies p q).

end hide
