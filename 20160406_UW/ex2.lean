import data.nat
open nat

definition id {A : Type} (a : A) := a

check id 10

check @id nat 10

set_option pp.all true

check id 10

check @id nat 10

variables (A : Type)  (R : A → A → Prop)
variables (a b c : A) (f : A → A → A)

theorem simple (H₁ : R (f a a) (f a a)) (H₂ : a = b) :
               R (f a b) (f b a) :=
eq.subst H₂ H₁

reveal simple
print simple

example (H₁ : R (f a a) (f a a)) (H₂ : a = b) :
        R (f a b) (f b a) :=
@eq.subst A a b (λ x : A, R (f a x) (f x a)) H₂ H₁
