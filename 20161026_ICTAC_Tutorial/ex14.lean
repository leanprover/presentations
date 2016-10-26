/- Other forms of reduction -/

constants m n : nat
constant b : bool

print "reducing pairs"
eval (m, n).1        -- m
eval (m, n).2        -- n

print "reducing boolean expressions"
eval tt && ff        -- ff
eval ff && b         -- ff

print "reducing arithmetic expressions"
eval n + 0           -- n
eval n + 2           -- succ (succ n)
eval 2 + 3           -- 5
