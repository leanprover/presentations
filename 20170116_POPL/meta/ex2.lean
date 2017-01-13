example (p q : Prop) (hp : p) (hq : q) : p ∧ q ∧ p :=
begin
  /- Hover over `apply`, its type is:

        tactic.interactive.apply : interactive.types.qexpr0 → tactic unit

     Inside begin-end blocks, tactics in the namespace tactic.interactive
     have special treatment in the parser. First, we don't need to open
     the namespace tactic.interactive. Second, quotations are introduced
     automatically. The type qexpr0 is just an alias for pexpr, but it instructs the parser
     to parse an expression, and auto quote it. That is,

           apply and.intro

     is syntax sugar for

          tactic.interactive.apply `(and.intro)

     The file library/init/meta/interactive.lean defines many "interactive"
     tactics using this approach. Users can easily add new "interactive" tactics.

     We can inspect intermediate states by pressing Ctrl-c-Ctrl-g (Emacs) and
     Ctrl-Shift-Enter (VS Code)
  -/
  apply and.intro,
  exact hp,
  apply and.intro,
  exact hq,
  exact hp
end

example {α : Type} {x y z w : α} (h₁ : x = y) (h₂ : y = z) (h₃ : z = w) : x = w :=
begin
  apply eq.trans h₁,
  apply eq.trans h₂,
  assumption   -- applied h₃
end

example : ∀ a b c : ℕ, a = b → a = c → c = b :=
begin
  /- We can also name hypotheses -/
  intros,
  apply eq.trans,
  apply eq.symm,
  repeat { assumption }
end

/- Structuring proofs -/
example (p q r : Prop) : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
begin
  apply iff.intro,
  {intro h,
   cases h^.right with hq hr,
    {show (p ∧ q) ∨ (p ∧ r),
        from or.inl ⟨h^.left, hq⟩ },
    {show (p ∧ q) ∨ (p ∧ r),
        from or.inr ⟨h^.left, hr⟩ }},
  {intro h,
   cases h with hpq hpr,
   {show p ∧ (q ∨ r),
      from ⟨hpq^.left, or.inl hpq^.right⟩ },
   {show p ∧ (q ∨ r),
     from ⟨hpr^.left, or.inr hpr^.right⟩ }}
end

/- Rewriting -/
section rw_examples

variables (f : ℕ → ℕ) (k : ℕ)

example (h₁ : f 0 = 0) (h₂ : k = 0) : f k = 0 :=
begin
  rw [h₂, h₁]
end

example {a b : ℕ} (h₁ : a = b) (h₂ : f a = 0) : f b = 0 :=
begin
  rw [-h₁, h₂]
end

end rw_examples

/- Quick examples with the Lean simplifier -/
section simp_examples

variables (x y z : ℕ) (p : ℕ → Prop)
premise   (h : p (x * y))

example : (x + 0) * (0 + y * 1 + z * 0) = x * y :=
by simp

example (h : p ((x + 0) * (0 + y * 1 + z * 0))) : p (x * y) :=
begin
  simp at h,
  assumption
end

def f (m n : ℕ) : ℕ :=
m + n + m

example {m n : ℕ} (h₁ : n = 1) (h₂ : 0 = m) : (f m n) * m = m :=
by simp [f, h₁, h₂^.symm]

end simp_examples
