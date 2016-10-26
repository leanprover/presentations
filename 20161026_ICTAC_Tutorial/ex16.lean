def double (x : ℕ) : ℕ := x + x

print double
check double 3
eval double 3    -- 6

def square (x : ℕ) := x * x
print square
check square 3
eval square 3    -- 9

def do_twice (f : ℕ → ℕ) (x : ℕ) : ℕ := f (f x)

eval do_twice double 2    -- 8

/- These definitions are equivalent to -/
def double' : ℕ → ℕ := λ x, x + x
def square' : ℕ → ℕ := λ x, x * x
def do_twice' : (ℕ → ℕ) → ℕ → ℕ := λ f x, f (f x)
