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

/- In this version we can fuse 3 loops over the arguments to an
   application, giving a ~20% speedup. -/
meta def exp_app (fmt_exp : expr -> format) : list expr → format
| [] := format.nil
| (e :: []) := "(" ++ fmt_exp e ++ ")"
| (e :: es) := "(" ++ fmt_exp e ++ ") " ++ exp_app es

meta def exp : expr → format
| (expr.elet n ty val body) :=
    "let" ++ let_binding (to_string n) (exp ty) (exp $ expr.instantiate_var body (mk_local n ty)) ++
    format.line ++ "in" ++ format.space ++ exp body
| (expr.app f arg) :=
    let fn := expr.get_app_fn (expr.app f arg),
        args := expr.get_app_args (expr.app f arg)
    in exp fn ++ format.space ++ exp_app exp args
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
    env ← get_env,
    opts ← get_options,
    let fs := list.taken 10 $ environment.fold env [] (fun decl decls, fmt.decl decl :: decls) in
    monad.mapm (fun f, tactic.trace (format.to_string f opts ++ "\n")) fs,
    return ()

/- We can then just run the main function to format all declarations in the environment. -/
run_command main
