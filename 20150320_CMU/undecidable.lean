-- Church number  λx f, f (f (f ... (f x) ...))
constant i : Type₁
definition Num := i → (i → i) → i
definition add (n : Num) (m : Num) : Num :=
λx f, n (m x f) f

definition mul (n : Num) (m : Num) : Num :=
λx f, n x (λz, (m z f))

definition zero   : Num := λx f, x
definition one    : Num := λx f, f x
definition two    : Num := λx f, f (f x)
definition three  : Num := λx f, f (f (f x))
definition four   : Num := λx f, f (f (f (f x)))

attribute zero one two three add mul four [reducible]

notation a + b := add a b
notation a * b := mul a b
notation 0     := zero
notation 1     := one
notation 2     := two
notation 3     := three
notation 4     := four

constant C  : Num → Type₁
constant mk : Π (n : Num), C n

example : C (3 + 3 + 2) := mk (2 * _)
