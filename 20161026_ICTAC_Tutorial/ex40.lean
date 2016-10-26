/- Universal quantifier

* Introduction:

Given a proof of p x, in a context where x : A is arbitrary,
we obtain a proof ∀ x : A, p x.

In the propositions-as-types interpretation

Given a term t of type B x, in a context where x : A is arbitrary,
we have (λ x : A, t) : (Π x : A, B x).

* Elimination:

Given a proof ∀ x : A, p x and any term t : A, we obtain a proof of p t.

In the propositions-as-types interpretation

Given a term s : Π x : A, B x and any term t : A, we have s t : B t.
-/

variables (A : Type) (p q : A → Prop)

example : (∀ x : A, p x ∧ q x) → ∀ y : A, p y  :=
assume h : ∀ x : A, p x ∧ q x,
take y : A,
show p y, from (h y)^.left

example : (∀ x : A, p x ∧ q x) → ∀ y : A, p y  :=
assume h : ∀ x : A, p x ∧ q x,
take z : A,
show p z, from and.elim_left (h z)

example : (∀ x : A, p x ∧ q x) → ∀ y : A, p y  :=
λ h y, (h y)^.left

example (h : ∀ x : A, p x ∧ q x) (y : A) : p y  :=
(h y)^.left

example (h : ∀ x : A, p x ∧ q x) (y : A) : p y  :=
have p y ∧ q y, from h y,
this^.left
