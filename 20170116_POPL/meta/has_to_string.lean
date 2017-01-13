/-
Lean tactics can also be used to synthesize code.
The tactic mk_dec_eq_instance is an example of such tactic.
Here, we implement a small tactic that synthesizes a
term of type (has_to_string Enum) for an enumeration type.
-/
open tactic expr

/- When we execute (vm_eval e), if there is an instance of (has_to_string e),
   Lean will automatically use it to display the result.
   The Lean standard library provides instances for many types (e.g., nat, int, list). -/
vm_eval [1, 2, 3]

/- An enumeration type is just an inductive datatype where
   every constructor has 0 arguments. -/
inductive color
| red | blue | green

open color

/- We don't have an instance of (has_to_string color) yet.
   Thus, Lean uses the vm_obj pretty printer.
   vm_obj is the Lean object runtime representation.

   The following output is not very readable. -/
vm_eval [red, blue, green, red]

/- We now define a tactic for automatically generating has_to_string instances for
   enumeration types. -/

/-- First, we define an auxiliary tactic (close_goals_using ns) that closes
    (length ns) goals of the form |- string using the names in ns. -/
meta def close_goals_using : list name → tactic unit
| []      := now <|> fail "mk_enum_has_to_string tactic failed, unexpected number of goals"
| (name.mk_string s p :: cs) := do
  /- We just use the suffix s of the name. That is, if the head of the list is (color.blue),
     we use just the string "blue" to close the goal.

     The tactic string.to_expr converts a string into a Lean expression that
     represents it.

   It is implemented in Lean, and we can
   jump to its definition by using `M-.` (on Emacs) and `F12` (on VS Code).
   On VS Code, we can also "peek" on its definition by typing (Alt-F12).
  -/
  s^.to_expr >>= exact,
  close_goals_using cs
| _       := fail "mk_enum_has_to_string tactic failed, unexpected constructor name"

/-- The tactic mk_enum_has_to_string discharges goals of the form (has_to_string Enum),
    where Enum is an enumeration type, i.e., an inductive datatype where each constructor
    is nullary. -/
meta def mk_enum_has_to_string : tactic unit :=
do
  env ← get_env,
  /- The constructor tactic is applying the constructor has_to_string.mk -/
  constructor,
  /- The goal is now of the form Enum -> string.
     The tactic intro1 introduces a new hypothesis (e : Enum), and returns it. -/
  e ← intro1,
  /- We infer the type of e, and put it in weak-head-normal-form, and extract the type name. -/
  (const Enum []) ← infer_type e >>= whnf | failed,
  when (¬ env^.is_inductive Enum) (fail "mk_has_to_string failed, type is not an inductive datatype"),
  /- Remark: we are not checking whether Enum is indeed an enumeration type.
     Exercise: implement this additional check using
        environment.constructors_of : environment → name → list name
        and
        infer_type : expr → tactic expr
  -/
  /- (env^.constructors_of Enum) is just syntax sugar for
     (environment.constructors_of env Enum)
     cs is a list of names  -/
  cs ← return $ env^.constructors_of Enum,
  /- Split the goal in cases. It will produce one case for each constructor. -/
  cases e,
  /- Each goal has type string. We close them using the constructor names. -/
  close_goals_using cs

/- Now, we automatically generate an instance using our mk_enum_has_to_string tactic. -/
instance : has_to_string color :=
by mk_enum_has_to_string

vm_eval [red, blue, green, red]

/- Advanced exercise: implement a tactic for synthesizing (has_to_string I) instances
   for arbitrary inductive datatypes. Use the tactic mk_dec_eq_instance from the standard
   library as a template. -/
