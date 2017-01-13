/-
Basic lean examples
-/

variables (α : Type) (p q : α → Prop)

/-
The keywords `assume` and `take` are just syntax sugar for λ.
(show t, from p) is just syntax sugar for the type ascription (p : t)

We can inspect the type of and.left by hovering over it.
-/
example : (∀ x : α, p x ∧ q x) → ∀ y : α, p y  :=
assume h : ∀ x : α, p x ∧ q x,
take y : α,
show p y, from and.left (h y)

/-
Lean can infer the types of h and y.

In the following example (h y)^.left is syntax sugar for
and.left (h y)

In general, t^.id works in the following way.
- Infer type of `t`
- If it is of ther form (C ...) where C is a constant,
search for declaration C.id.
-/
example : (∀ x : α, p x ∧ q x) → ∀ y : α, p y  :=
λ h y, (h y)^.left

vm_eval [1, 2, 3]^.length

example : (∃ x : α, p x ∧ q x) → ∃ y : α, p y  :=
assume h : ∃ x : α, p x ∧ q x,
exists.elim h (assume (x : α) (h : p x ∧ q x),
  exists.intro x h^.left)

example : (∃ x : α, p x ∧ q x) → ∃ y : α, p y  :=
λ h,
match h with
| exists.intro x (and.intro hp hq) := exists.intro x hp
end

/-
Same example using anonymous constructor
-/
example : (∃ x : α, p x ∧ q x) → ∃ y : α, p y  :=
λ ⟨x, hp, hq⟩, ⟨x, hp⟩

universe variable u

/-
Lean supports calculations proofs.

Unifier has support for type class.
  - add_zero is defined for add_monoid.
  - left_distrib is defined for distrib.
  - We have obtain their types by hovering over them.

Try auto-completion.
Try jump-to-definition.
-/
lemma ring_mul_zero {α : Type u} [ring α] (a : α) : a * 0 = 0 :=
have a * 0 + 0 = a * 0 + a * 0, from calc
     a * 0 + 0 = a * 0         : add_zero (a*0)
           ... = a * (0 + 0)   : congr_arg (mul a) (eq.symm (add_zero 0))
           ... = a * 0 + a * 0 : left_distrib a 0 0,
show a * 0 = 0, from (add_left_cancel this)^.symm

def app {α : Type u} : list α → list α → list α
| []     l := l
| (h::t) l := h :: app t l

check [1, 2, 3]

vm_eval app [1, 2, 3] [2, 4]

def fib : nat → nat
| 0     := 1
| 1     := 1
| (a+2) := fib a + fib (a+1)

vm_eval fib 10

/- tt is the Boolean true -/
check tt

check tt * ff -- Error

check band

/-
⟨band⟩ is syntax sugar for has_mul.mk band
-/
instance : has_mul bool :=
⟨band⟩

check tt * ff
vm_eval tt * ff
vm_eval tt * tt

example (b₁ b₂ : bool) : b₁ * b₂ = band b₁ b₂ :=
rfl

def n : nat := 1

check n + tt -- Error

instance : has_coe bool nat :=
⟨λ b, cond b 1 0⟩

check n + tt
check (1:nat) + tt
