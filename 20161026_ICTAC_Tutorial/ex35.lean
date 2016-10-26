/- Falsity

   Elimination: anything follows from false. -/

variables p q : Prop

example (h : false) : p :=
false.elim h

example (h : false) : p :=
@false.elim p h

/- Negation -/

print not

/- If we have (h1 : not p) and (h2 : p) we can derive false -/

example (h1 : not p) (h2 : p) : false :=
h1 h2

example (h1 : not p) (h2 : p) : q :=
false.elim (h1 h2)

example (h1 : not p) (h2 : p) : q :=
absurd h2 h1
