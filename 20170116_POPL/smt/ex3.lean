namespace imp
open tactic

@[reducible]
def uname := string

/- Define a small expression language -/
inductive aexp
| val   : nat → aexp
| var   : uname → aexp
| plus  : aexp → aexp → aexp
| times : aexp → aexp → aexp

instance : decidable_eq aexp :=
by mk_dec_eq_instance

/- We mark value as [reducible] to make sure type class resolution
   finds instances for (has_add value), (has_mul_value), etc. -/
@[reducible]
def value := nat

/- A state is just a mapping from names to values. -/
def state := uname → value

open aexp

/- Arithmetic expression evaluator. -/
def aval : aexp → state → value
| (val n)      s := n
| (var x)      s := s x
| (plus a₁ a₂) s := aval a₁ s + aval a₂ s
| (times a₁ a₂) s := aval a₁ s * aval a₂ s

example : aval (plus (val 3) (var "x")) (λ x, 0) = 3 :=
rfl

/- Constant folding -/
def asimp_const : aexp → aexp
| (val n)      := val n
| (var x)      := var x
| (plus a₁ a₂) :=
  match asimp_const a₁, asimp_const a₂ with
  | val n₁, val n₂ := val (n₁ + n₂)
  | b₁,     b₂     := plus b₁ b₂
  end
| (times a₁ a₂) :=
  match asimp_const a₁, asimp_const a₂ with
  | val n₁, val n₂ := val (n₁ * n₂)
  | b₁,     b₂     := times b₁ b₂
  end

example : asimp_const (plus (plus (val 2) (val 3)) (var "x")) = plus (val 5) (var "x") :=
rfl

/- Put equational lemmas for aval and asimp_const in the default [ematch] lemma set -/
attribute [ematch] asimp_const aval

/- Prove basic property aboud asimp_const. -/
lemma aval_asimp_const (a : aexp) (s : state) : aval (asimp_const a) s = aval a s :=
begin [smt]
 induction a,
 /- Note that we have to case split on the nested (asimp_const a) and (asimp_const a_1) terms. -/
 all_goals {destruct (asimp_const a), all_goals {destruct (asimp_const a_1), eblast}}
end

/-
Exercise: the proof above is not robust because it relies on automatically generated
names produced by the induction tactic, and on the fact that we have only binary operators.

Use the Lean API to traverse the local context and collect case-split candidates.
-/

end imp
