import data.set

/-
The Lean simplifer can be also use to "flat" nested application of associatiave operators,
and "sort" associative/commutative ones.

The Lean simplifier can be viewed as a ordered rewriting system.
It can be customized with user provided lemmas.

It is well-known that we can use ordered rewriting to "sort" nested applications
of associative-commutative (AC) operators.
Let's assume we have an AC operator op.
-/
constant α    : Type
constant op   : α → α → α
axiom h_comm  : ∀ x y, op x y = op y x
axiom h_assoc : ∀ x y z, op (op x y) z = op x (op y z)

/-
To "sort" the nested op-applications, we also need
the following lemma that follows from h_comm and h_assoc.
-/
lemma h_left_comm : ∀ x y z, op x (op y z) = op y (op x z) :=
left_comm _ h_comm h_assoc

/- Now, we declare notation for (op a b) -/
infix `∙`:65 := op

example (a b c d : α) : a ∙ b ∙ c ∙ d = (c ∙ b) ∙ (a ∙ d) :=
by simp [h_comm, h_assoc, h_left_comm]

/- We can add h_comm, h_assoc and h_left_comm
   to the main simp_lemmas (set of simplification rules) -/
attribute [simp] h_comm h_assoc h_left_comm

/- Now, these lemmas are automatically used. -/
example (a b c d : α) : a ∙ b ∙ c ∙ d = (c ∙ b) ∙ (a ∙ d) :=
by simp

/- We can also locally remove lemmas from the [simp] -/
local attribute [-simp] h_comm h_assoc h_left_comm

example (a b c d : α) : a ∙ b ∙ c ∙ d = (c ∙ b) ∙ (a ∙ d) :=
/- Now, the following will fail since h_comm, h_assoc and h_left_comm
   have been removed from the simp set [simp] -/
by simp

/- We can declare our own simp sets.
   The command mk_simp_attr is implemented in Lean
   using the attribute manager API.
   We discuss the attribute manager later. -/
run_command mk_simp_attr `sort_op

attribute [sort_op] h_comm h_assoc h_left_comm

example (a b c d : α) : a ∙ b ∙ c ∙ d = (c ∙ b) ∙ (a ∙ d) :=
/- The modifier 'with' instructs simp to use the given simp set -/
by simp with sort_op

open tactic

/-
Note that (left_comm op h_comm h_assoc) is not recognized as the rewrite rule
we expect
-/
check left_comm op h_comm h_assoc -- : left_commutative f

/- So, we define an auxiliary lemma with the "right" type. -/
lemma {u} left_comm_rw {α : Type u} (f : α → α → α) (h_comm : commutative f) (h_assoc : associative f) :
                       ∀ x y z, f x (f y z) = f y (f x z) :=
left_comm f h_comm h_assoc

/- The simp sets are first-class citizens in Lean, we
   can write functions that create them.

   Given proof terms h_comm and h_assoc, the tactic
   (mk_sort_simp_set h_comm h_assoc) returns
   a simp set containing h_comm, h_assoc and the
   associated left_comm lemma implied by h_comm and h_assoc. -/
meta def mk_sort_simp_set (op : expr) (h_comm : expr) (h_assoc : expr) : tactic simp_lemmas :=
do
  S ← return simp_lemmas.mk,
  S ← S^.add h_comm,
  S ← S^.add h_assoc,
  h_left_comm ← to_expr `(left_comm_rw %%op %%h_comm %%h_assoc) >>= whnf,
  S^.add h_left_comm

declare_trace sort_ac

meta def sort_ac_core (op : expr) (h_comm : expr) (h_assoc : expr) : tactic unit :=
do S ← mk_sort_simp_set op h_comm h_assoc,
   /- When tracing sort_ac, we pretty print the generated simp_set. -/
   when_tracing `sort_ac (S^.pp >>= trace),
   simplify_goal S,
   try reflexivity

open expr

meta def is_bin_app : expr → tactic (expr × expr × expr)
| (app (app fn a1) a2) := return (fn, a1, a2)
| _                    := failed

/- Now, we use type class resolution to retrieve the comm and assoc lemmas. -/
meta def sort_ac : tactic unit :=
do (lhs, rhs) ← target >>= match_eq,
   (op, _, _) ← is_bin_app lhs,
   h_assoc    ← to_expr `(is_associative.assoc %%op),
   h_comm     ← to_expr `(is_commutative.comm %%op),
   sort_ac_core op h_comm h_assoc

/- We still did not declare the instances is_associative and is_commutative
   for op.

   We have to mark them as noncomputable because we did not define them.
-/
noncomputable instance : is_associative _ op :=
⟨h_assoc⟩

noncomputable instance : is_commutative _ op :=
⟨h_comm⟩

example (a b c d : α) : a ∙ b ∙ c ∙ d = (c ∙ b) ∙ (a ∙ d) :=
by sort_ac

example (s₁ s₂ s₃ : set nat) : s₁ ∪ s₂ ∪ s₃ = s₃ ∪ s₁ ∪ s₂ :=
by sort_ac

set_option trace.sort_ac true

example (a b c : nat) : a + b + c = c + b + a :=
by sort_ac
