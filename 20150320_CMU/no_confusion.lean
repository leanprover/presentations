definition no_confusion_type (P : Type) (a b : nat) : Type :=
nat.cases_on a
  (nat.cases_on b
    (P → P)
    (λ b₁, P))
  (λa₁, nat.cases_on b
    P
    (λb₁, (a₁ = b₁ → P) → P))

definition no_confusion {P : Type} {a b : nat} (H : a = b) : no_confusion_type P a b :=
have aux : (∀h : a = a, no_confusion_type P a a), from
  λh, nat.cases_on a
        (λ Hp, Hp)
        (λ Hp He, He rfl),
eq.rec_on H aux H

open nat
example (n : nat) : zero ≠ succ n :=
λH, no_confusion H

example (a b : nat) : succ a = succ b → a = b :=
λH, no_confusion H (λe, e)
