open tactic

/-
Hover over tactics to view their types.

The notation `id is a "name quotation".
For example `foo.bar is syntax sugar for
        (name.mk_string "bar" (name.mk_string "foo" name.anonymous))
-/
example (p q : Prop) : p → q → q ∧ p :=
by do
  h₁ ← intro `h₁,
  h₂ ← intro `h₂,
  trace_state,
  constructor,
  exact h₂,
  exact h₁

example (a b c : nat) : a = b → c = b → a = c :=
by do
  intros,
  transitivity,
  trace_state,
  assumption,
  symmetry,
  assumption

/-
`(t) is a quoted (pre-)expression.
The tactic `to_expr` elaborates an expression with respect
to environment and local context of the main goal.

The notation t₁ >>= t₂ is syntax sugar for (bind t₁ t₂),
 i.e., (do a ← t₁, t₂ a)
-/
example (a b c : nat) : a = b → c = b → a = c :=
by do
  intro `h₁,
  intro `h₂,
  to_expr `(eq.trans h₁ (eq.symm h₂)) >>= exact

/-
The tactic get_local retrieves the hypothesis
with the given (user) name.
-/
example (a b c : nat) : a = b → c = b → a = c :=
by do
  intros,
  a ← get_local `a,
  trace "type of a: ", infer_type a >>= trace,
  subst a,
  trace "----", trace_state,
  get_local `b >>= subst,
  trace "----", trace_state,
  reflexivity

/-
Meta definitions are similar to regular definitions.
However,
1- They support unbounded recursion.

2- A regular definition cannot use a meta definition,
   but a meta definition can use a regular one.

The following definition constructs a Lean expression
that encodes the given number.
-/
meta def expr_of_nat : nat → tactic expr
| 0 := to_expr `(0)
| 1 := to_expr `(1)
| n :=
  do r ← expr_of_nat (n / 2),
  if n % 2 = 0
  then to_expr `(bit0 %%r)
  else to_expr `(bit1 %%r)

/-
The following tactic adds a definition
    def n : nat := v
to the environment.
-/
meta def add_const_decl (n : name) (v : nat) : tactic unit :=
do env ← get_env,
   Nat ← to_expr `(nat),
   val ← expr_of_nat v,
   add_decl (mk_definition n [] Nat val)

/-
The command run_command is useful for running (top-level) tactics
that update the environment.
-/
run_command do
  add_const_decl `x1 10,
  add_const_decl `x2 20

print x1
print x2
vm_eval x1 + x2

/- The decidable type class -/
print decidable

/- We can "branch" on decidable propositions -/
def Max (a b : nat) : nat :=
if a > b then a else b

set_option pp.all true
print Max
set_option pp.all false

vm_eval Max 10 20

inductive tree (α : Type)
| leaf : α → tree
| node : tree → tree → tree

/- The following fails because we do not have
   an instance for (decidable t₁ t₂) -/
check λ t₁ t₂ : tree nat, if t₁ = t₂ then "equal" else "not equal"

/- It is quite tedious to write these instances by hand.
   Given n constructors, we have n^2 cases. -/
open tree
def tree_has_deceq {α : Type} [decidable_eq α] : ∀ t₁ t₂ : tree α, decidable (t₁ = t₂)
| (leaf a₁) (leaf a₂) :=
  if h : a₁ = a₂ then decidable.is_true (h ▸ rfl)
  else decidable.is_false (λ h₁, tree.no_confusion h₁ (λ h₂, absurd h₂ h))
| (node l₁ r₁) (node l₂ r₂) :=
  match tree_has_deceq l₁ l₂ with
  | decidable.is_false h  := decidable.is_false (λ h₁, tree.no_confusion h₁ (λ h₁ h₂, absurd h₁ h))
  | decidable.is_true  h₁ :=
    match tree_has_deceq r₁ r₂ with
    | decidable.is_false h  := decidable.is_false (λ h₁, tree.no_confusion h₁ (λ h₁ h₂, absurd h₂ h))
    | decidable.is_true  h₂ := decidable.is_true (h₁ ▸ h₂ ▸ rfl)
    end
  end
| (leaf a₁) (node l₂ r₂) := decidable.is_false (λ h, tree.no_confusion h)
| (node l₁ r₁) (leaf a₂) := decidable.is_false (λ h, tree.no_confusion h)

/- We have implemented in Lean a tactic that tries
   to synthesize a decidable_eq instance for a given inductive datatype. -/
instance {α : Type} [decidable_eq α] : decidable_eq (tree α) :=
by mk_dec_eq_instance

/- Now, the following works -/
check λ t₁ t₂ : tree nat, if t₁ = t₂ then "equal" else "not equal"
