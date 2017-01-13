open tactic

namespace fmt

meta def exp : expr → format
| (expr.elet n ty val body) := "let"
| (expr.app f args) := "app"
| (expr.const c ls) := "const"
| (expr.local_const n n' bi ty) := "local_const"
| (expr.macro _ _ _) := "macro"
| (expr.pi n bi sort ty) := "pi"
| (expr.lam n bi ty body) := "lambda"
| (expr.mvar n ty) := "bug"
| (expr.sort level) := "sort"
| (expr.var i) := "i"

meta def decl : declaration → format
| (declaration.defn n us ty value _ _) :=
    "def" ++ format.space ++ to_string n ++ format.space ++ ":" ++ format.space ++ exp ty ++ format.space ++ ":=" ++ format.line ++
    exp value
| (declaration.ax n us ty) := "axiom" ++ format.space ++ to_string n
| (declaration.cnst n us body _) := "constant" ++ format.space ++ to_string n
| (declaration.thm n us ty body) := "theorem" ++ format.space ++ to_string n

end fmt

-- meta def format_concat : list format → format
-- | [] := format.nil
-- | (f :: fs) := f ++ format_concat fs

set_option profiler true

meta def main : tactic unit := do
    env ← get_env,
    opts ← get_options,
    let fs := environment.fold env [] (fun decl decls, fmt.decl decl :: decls) in
    tactic.trace $ format.to_string (format_concat $ fs) opts

run_command main
