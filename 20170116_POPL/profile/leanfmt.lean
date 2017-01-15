open tactic

-- set_option trace.compiler true

namespace fmt

meta def format.concat : list format -> format
| [] := format.nil
| (f :: fs) := f ++ format.concat fs

meta definition mk_local (n : name) (ty : expr) : expr :=
  expr.local_const n n binder_info.default ty

meta def binder (n : format) (ty : format) : format :=
  "(" ++ n ++ format.space ++ ":" ++ format.space ++ ty ++ ")"

meta def let_binding (n : format) (ty : format) (val : format) : format :=
    "x" ++ format.space ++ ":" ++ format.space ++ ":=" ++ val

def intersperse {A : Type} (elem : A) : list A → list A
| [] := []
| (x :: []) := [x]
| (x :: xs) := x :: elem :: intersperse xs

meta def exp_app (fmt_exp : expr -> format) (fn : expr) (args : list expr) : format :=
    fmt_exp fn ++ format.space ++
    (format.concat $
        intersperse format.space $ list.map (fun e, "(" ++ fmt_exp e ++ ")") args)

/- We define a simple pretty printing function, reusing the `format` type exposed
   from the Lean core. -/
meta def exp : expr → format
| (expr.elet n ty val body) :=
    "let" ++ let_binding (to_string n) (exp ty) (exp $ expr.instantiate_var body (mk_local n ty)) ++
    format.line ++ "in" ++ format.space ++ exp body
| (expr.app f arg) :=
    let fn := expr.get_app_fn (expr.app f arg),
        args := expr.get_app_args (expr.app f arg)
    in exp_app exp fn args
| (expr.const c _) := to_string c
| (expr.local_const n n' bi ty) := to_string n
| (expr.macro _ _ _) := "macro"
| (expr.pi n bi sort ty) :=
    "forall" ++ format.space ++ binder (to_string n) (exp sort) ++ "," ++
    format.group (format.line ++ format.space ++ exp (expr.instantiate_var ty (mk_local n sort)))
| (expr.lam n bi ty body) :=
    "fun" ++ format.space ++ binder (to_string n) (exp ty) ++ "," ++
        format.group (format.line ++ exp (expr.instantiate_var body (mk_local n ty)))
| (expr.mvar n ty) := "?" ++ to_string n
| (expr.sort _) := "Type"
| (expr.var i) := "i"

meta def decl : declaration → format
| (declaration.defn n us ty value _ _) :=
    "def" ++ format.space ++ to_string n ++ format.space ++ ":" ++ format.space ++ exp ty ++ format.space ++ ":=" ++
    format.indent (exp value) 2
| (declaration.ax n us ty) := "axiom" ++ format.space ++ to_string n
| (declaration.cnst n us body _) := "constant" ++ format.space ++ to_string n
| (declaration.thm n us ty body) := "theorem" ++ format.space ++ to_string n

end fmt

/- Turn on the profiler. -/
set_option profiler true

meta def main : tactic unit := do
    /- Get the global environment. -/
    env ← get_env,
    /- Get the global options. -/
    opts ← get_options,
    /- Do a fold over all the declarations in the environment. -/
    let fs := environment.fold env [] (fun decl decls, fmt.decl decl :: decls) in
    /- Print all the formatted declarations. -/
    monad.mapm (fun f, tactic.trace (format.to_string f opts ++ "\n")) fs,
    return ()

/- We can then just run the main function to format all declarations in the environment. -/
-- run_command main
