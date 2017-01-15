/- We revist an example from earlier, showing how the debugger
can be used to interactively debug & introspect on tactics. -/

/- First we import the debugger. -/
import tools.debugger

/- Then we set the option which enables the debugger. -/
set_option debugger true

/- We then set the option which enables autorun, which
   allows the debugger to launch the CLI debugger upon
   execution of the file. -/
set_option debugger.autorun true
open tactic expr

inductive color
| red | blue | green

open color

/- We now define a tactic for automatically generating has_to_string instances for
   enumeration types. -/
meta def close_goals_using : list name → tactic unit
| []      := now <|> fail "mk_enum_has_to_string tactic failed, unexpected number of goals"
| (name.mk_string s p :: cs) := do
  s^.to_expr >>= exact,
  close_goals_using cs
| _       := fail "mk_enum_has_to_string tactic failed, unexpected constructor name"

/- Imagine instead if we want to stop in the middle of an executing tactic.
   We can use a simple trick to stop at an exact position in the code. -/

@[breakpoint, irreducible]
meta def break : tactic unit :=
  return ()

meta def mk_enum_has_to_string : tactic unit :=
do
  env ← get_env,
  constructor,
  e ← intro1,
  (const Enum []) ← infer_type e >>= whnf | failed,
  /- Now if we call break, we will stop execution at this point. We can
     then walk the stack looking at variables or continue execution. -/
  break,
  when (¬ env^.is_inductive Enum) (fail "mk_has_to_string failed, type is not an inductive datatype"),
  cs ← return $ env^.constructors_of Enum,
  cases e,
  close_goals_using cs

/- Now, we automatically generate an instance using our mk_enum_has_to_string tactic. -/
instance : has_to_string color :=
by mk_enum_has_to_string

vm_eval [red, blue, green, red]
