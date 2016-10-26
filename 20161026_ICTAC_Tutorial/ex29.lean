/- Simplifications -/

/- We can avoid writing the term Proof repeatedly by conflating Proof p with p itself. -/

/- Whenever we have p : Prop, we can interpret p as a type, namely,
   the type of its proofs.
   We can then read t : p as the assertion that t is a proof of p.
-/

constant p : Prop
constant t : p

/- Once we make this identification, the rules for implication
   show that we can pass back and forth between implies p q and p → q.

   In other words, implication between propositions p and q corresponds to
   having a function that takes any element of p to an element of q.
   As a result, the introduction of the connective implies is entirely redundant:
   we can use the usual function space constructor p → q
   from dependent type theory as our notion of implication. -/

/- Curry-Howard Isomorphism -/

constant q : Prop

def thm1 : p → q → p :=
λ (hp : p) (hq : q), hp

theorem thm2 : p → q → p :=
assume hp : p,
assume hq : q,
hp

lemma thm3 : p → q → p :=
assume hp : p,
assume hq : q,
show p, from hp
