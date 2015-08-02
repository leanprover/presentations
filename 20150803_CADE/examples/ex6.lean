open nat

inductive inh [class] (A : Type) : Type :=
mk : A → inh A

open inh

definition def (A : Type) [h : inh A] : A :=
match h with
| mk a := a
end

definition prop_inh [instance] : inh Prop :=
mk true

definition nat_inh [instance] : inh nat :=
mk 0

definition fun_inh [instance] (A B : Type) [h : inh B] : inh (A → B) :=
mk (λ x : A, def B)

definition prod_inh [instance] (A B : Type) [ha : inh A] [hb : inh B] : inh (A × B) :=
mk (def A, def B)

-- set_option class.trace_instances true

eval def (bool → nat → nat × Prop × nat)
