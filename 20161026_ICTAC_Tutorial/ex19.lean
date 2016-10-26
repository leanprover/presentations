variables (A B C : Type)
variables (g : B → C) (f : A → B) (h : A → A)
variable x : A

def compose := g (f x)
def do_twice := h (h x)
def do_thrice := h (h (h x))

print compose
print do_twice
print do_thrice
