def compose (A B C : Type) (g : B → C) (f : A → B) (x : A) :
  C := g (f x)

def do_twice (A : Type) (h : A → A) (x : A) : A := h (h x)

def do_thrice (A : Type) (h : A → A) (x : A) : A := h (h (h x))

/- Variables -/

variables (A B C : Type)

def compose' (g : B → C) (f : A → B) (x : A) : C := g (f x)
def do_twice' (h : A → A) (x : A) : A := h (h x)
def do_thrice' (h : A → A) (x : A) : A := h (h (h x))
