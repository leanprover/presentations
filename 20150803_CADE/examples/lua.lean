import data.nat
open nat

definition f (a : nat) : nat := a + 10

(*
 local env     = get_env()
 local f_decl  = env:get("f")
 -- Traverse subterms of f
 f_decl:value():for_each(function (a) print(">> " .. tostring(a)) end)
 local nat     = Const("nat")
 -- Create the term λ x, f x + f x
 local add     = Const({"nat","add"})
 local f       = Const("f")
 local x       = Local("x", nat)
 local val     = Fun(x, add(f(x), f(x)))
 -- Create a new definition using the term above
 local g_decl  = mk_definition("g", mk_arrow(nat, nat), val)
 -- Type check it and get a "certified declaration"
 local g_cdecl = type_check(env, g_decl)
 set_env(env:add(g_decl))
*)

check g
eval g 1
