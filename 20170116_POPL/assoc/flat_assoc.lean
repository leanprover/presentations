/-
In this example, we implement a tactic for "flattening"
terms built using an associative operator. Suppose `op`
is an associative operator. Then, we build a tactic
that given a term such as

   (op (op a b) (op c d))

it returns a new term

  (op a (op b (op c d)))

and a proof that it is equal to the given one.
-/
import data.set
open tactic expr

/--
Return `some (a, b)` iff `e` is of the form `(op a b)`
-/
meta def is_bin_app (op : expr) : expr → option (expr × expr)
| (app (app fn a1) a2) := if op = fn then some (a1, a2) else none
| _                    := none

/--
The tactic (flat_with op assoc lhs rhs) returns the flattening of (op lhs rhs) and
proof that the resulting term is equal to (op lhs rhs).
- `op` is a binary operator
- `assoc` is a proof that it is associative

The tactic may fail if `op` is not a binary operator, if `assoc` is not a proof that
`op` is associative.
-/
meta def flat_with (op : expr) (assoc : expr) : expr → expr → tactic (expr × expr)
| lhs rhs :=
  match is_bin_app op lhs with
  | (some (lhs₁, lhs₂)) :=  do
    /- h₁ is a proof for (op lhs₂ rhs) = rhs₁ -/
    (rhs₁, h₁)  ← flat_with lhs₂ rhs,
    /- h₂ is a proof for (op lhs₁ rhs₁) = rhs₂ -/
    (rhs₂, h₂)  ← flat_with lhs₁ rhs₁,
    /- We want to generate a proof that (op (op lhs₁ lhs₂) rhs) = (op lhs₁ (op lhs₂ rhs))
       h₃ is a proof for (op (op lhs₁ lhs₂) rhs) = (op lhs₁ (op lhs₂ rhs))

       Remark: the standard library provides a coercion from expr to (expr → expr).
       Given (f a b : expr), this coercion allows us to write (f a b) instead of
       (app (app f a) b)
    -/
    h₃          ← return $ assoc lhs₁ lhs₂ rhs,
    /-
      Now, we want to use congruence to prove that given

         (op lhs₂ rhs) = rhs₁

      we have

         op lhs₁ (op lhs₂ rhs) = op lhs₁ rhs₁

      We can use the lemma congr_arg, it has type

         congr_arg : ∀ {α : Type u₁} {β : Type u₂} {a₁ a₂ : α} (f : α → β), a₁ = a₂ → f a₁ = f a₂

      It is quite inconvenient to use directly since it has 2 universe metavariables and 4 implicit arguments.
      Thus we use the helper tactic mk_app. It infers implicit arguments using type inference and
      type class resolution.
    -/
    h₄          ← mk_app `congr_arg [op lhs₁, h₁],
    /- Now, we use transitivity to build the proof for
         (op (op lhs₁ lhs₂) rhs) = rhs₂
       using
          h₃ : (op (op lhs₁ lhs₂) rhs) = (op lhs₁ (op lhs₂ rhs))
          h₄ : (op lhs₁ (op lhs₂ rhs)) = (op lhs₁ rhs₁)
          h₂ : (op lhs₁ rhs₁)          = rhs₂

       We could accomplish that by using mk_app twice, but here we demonstrate how to
       build this proof term using quotations and anti-quotations.

       A quoted term `(t) is a pre-term. The tactic to_expr elaborates a pre-term
       with respect to the current main goal. The notation %%t is an anti-quotation.
    -/
    h           ← to_expr `(eq.trans %%h₃ (eq.trans %%h₄ %%h₂)),
    return (rhs₂, h)
  | none          := do
    new_rhs ← return (op lhs rhs),
    h       ← mk_app `eq.refl [new_rhs],
    return (new_rhs, h)
  end

/--
The tactic (flat_core op assoc e) returns the flattening of `e` with respect to the binary operator `op`,
and proof that the resulting term is equal to `e`
  - `op` is a binary operator

  - `assoc` is a proof that it is associative
-/
meta def flat_core (op : expr) (assoc : expr) : expr → tactic (expr × expr)
| e :=
  match is_bin_app op e with
  | (some (lhs, rhs)) := do
    /- h₁ is a proof that rhs = new_rhs -/
    (new_rhs, h₁)  ← flat_core rhs,
    /- h₂ is a proof that (op lhs new_rhs) = new_app -/
    (new_app, h₂)  ← flat_with op assoc lhs new_rhs,
    /- We need a proof that (op lhs rhs) = new_app -/
    h              ← to_expr `(eq.trans (congr_arg %%(op lhs) %%h₁) %%h₂),
    return (new_app, h)
  | none          :=
    do pr ← mk_app `eq.refl [e],
       return (e, pr)
  end

/--
The tactic a_refl closes the current goal iff it is of the form (lhs = rhs),
and the flattening of lhs and rhs, with respect to op, is the same term. -/
meta def a_refl_core (op : expr) (assoc : expr) : tactic unit :=
do
  /- The tactic `target` returns the target of the main goal.
     That is, the type we are trying to synthesize an element of. -/
  t          ← target,
  /- The tactic (match_eq t) succeeds iff t is of the form (lhs = rhs) -/
  (lhs, rhs) ← match_eq t,
  (flat_lhs, h₁) ← flat_core op assoc lhs,
  (flat_rhs, h₂) ← flat_core op assoc rhs,
  /- The following tactic will fail if the flattening of lhs and rhs are not identical. -/
  guard (flat_lhs = flat_rhs),
  /- If flat_lhs and flat_rhs are the same term, then we build a proof that
     lhs and rhs are equal using transitivity and symmetry, and close the main
     goal using the `exact` tactic.

     The notation t₁ >>= t₂ is syntax sugar for (do a ← t₁, t₂ a)
  -/
  to_expr `(eq.trans %%h₁ (eq.symm %%h₂)) >>= exact

meta def a_refl_add : tactic unit :=
do op     ← to_expr `(@add nat _),
   assoc  ← to_expr `(@add_assoc nat _),
   a_refl_core op assoc

example (a b c d e f g : nat) : a + (b + c) = (a + b) + c :=
by a_refl_add

example (a b c d e f g : nat) : a + (b + c) + d = (a + b) + (c + d) :=
by a_refl_add

example (a b c d e f g : nat) : ((a + b) + c) + ((d + e) + (f + g))  = a + (b + (c + (d + (e + (f + g))))) :=
by a_refl_add

lemma ex₁ (a b c d e f g : nat) : ((a + b) + c) + ((d + e) + (f + g))  = a + (b + (c + (d + (e + (f + g))))) :=
by a_refl_add

/- We can use `print` to inspect the proof built in the previous example -/
print ex₁

/- We have a type class is_associative -/
print is_associative

/-- If a term `t` is of the form (op a b), and we have an instance for `is_associative op`,
    then (is_assoc_bin_app t) returns a proof that `op` is associative.
    Otherwise the tactic fails. -/
meta def is_assoc_bin_app : expr → tactic (expr × expr)
| (app (app op a1) a2) := do h ← to_expr `(is_associative.assoc %%op), return (op, h)
| _                    := failed

run_command to_expr `(0 + 2) >>= is_assoc_bin_app >>= λ p, trace p.2

/- The module data.set provides an instance for (is_associative set.union) -/
run_command to_expr `(({} : set nat) ∪ {}) >>= is_assoc_bin_app >>= λ p, trace p.2

/- Instruct Lean's pretty printer to show implicit arguments -/
set_option pp.implicit true

run_command to_expr `(({} : set nat) ∪ {}) >>= is_assoc_bin_app >>= λ p, trace p.2

meta def a_refl : tactic unit :=
do (lhs, rhs)  ← target >>= match_eq,
   (op, assoc) ← is_assoc_bin_app lhs,
   a_refl_core op assoc

example (a b c d e f g : nat) : ((a + b) + c) + ((d + e) + (f + g))  = a + (b + (c + (d + (e + (f + g))))) :=
by a_refl

example (s₁ s₂ s₃ s₄ : set nat) : (s₁ ∪ s₂) ∪ (s₃ ∪ s₄) = s₁ ∪ (s₂ ∪ (s₃ ∪ s₄)) :=
by a_refl
