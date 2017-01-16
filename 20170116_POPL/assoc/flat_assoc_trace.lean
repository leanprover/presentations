/-
In this file, we add tracing capabilities to
the flattening tactics we have defined at flat_assoc.lean.
-/
import data.set
open tactic expr

/- The command `declare_trace` add a new trace.flat_assoc option to Lean -/
declare_trace flat_assoc

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
  /- The tactic (when_tracing id tac) executes the tactic `tac` if
     the option trace.id is set to true.
  -/
  when_tracing `flat_assoc (do
     /- The tactic (pp e) pretty-prints the given expression.
        It returns the formatting object for `e`. It will
        format it with respect to the local context and environment associated
        with the main goal. -/
     lhs_fmt ← pp lhs,
     rhs_fmt ← pp rhs,
     trace (to_fmt "flattening " ++ lhs_fmt ++ " with " ++ rhs_fmt))
  >>
  match is_bin_app op lhs with
  | (some (lhs₁, lhs₂)) :=  do
    (rhs₁, h₁)  ← flat_with lhs₂ rhs,
    (rhs₂, h₂)  ← flat_with lhs₁ rhs₁,
    h₃          ← return $ assoc lhs₁ lhs₂ rhs,
    h₄          ← mk_app `congr_arg [op lhs₁, h₁],
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
    (new_rhs, h₁)  ← flat_core rhs,
    (new_app, h₂)  ← flat_with op assoc lhs new_rhs,
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
  t          ← target,
  when_tracing `flat_assoc (do
     t_fmt ← pp t,
     trace $ to_fmt ">> a_refl_core " ++ t_fmt),
  (lhs, rhs) ← match_eq t,
  when_tracing `flat_assoc (trace ">>> flattening lhs"),
  (flat_lhs, h₁) ← flat_core op assoc lhs,
  when_tracing `flat_assoc (trace ">>> flattening rhs"),
  (flat_rhs, h₂) ← flat_core op assoc rhs,
  guard (flat_lhs = flat_rhs),
  to_expr `(eq.trans %%h₁ (eq.symm %%h₂)) >>= exact

meta def is_assoc_bin_app : expr → tactic (expr × expr)
| (app (app op a1) a2) := do h ← to_expr `(is_associative.assoc %%op), return (op, h)
| _                    := failed

meta def a_refl : tactic unit :=
do (lhs, rhs)  ← target >>= match_eq,
   (op, assoc) ← is_assoc_bin_app lhs,
   a_refl_core op assoc

/- We can enable/disable the tracing messages
   using the set_option command.

   Later, we demonstrate how to use the Lean debugger and VM monitor. -/
set_option trace.flat_assoc true

example (a b c d e f g : nat) : ((a + b) + c) + ((d + e) + (f + g))  = a + (b + (c + (d + (e + (f + g))))) :=
by a_refl

set_option trace.flat_assoc false

example (s₁ s₂ s₃ s₄ : set nat) : (s₁ ∪ s₂) ∪ (s₃ ∪ s₄) = s₁ ∪ (s₂ ∪ (s₃ ∪ s₄)) :=
by a_refl
