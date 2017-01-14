import tools.super
open super tactic monad

meta def trivial_term_order (a b : expr) := ff -- most inferences in super require a term order

-- Let's look at how clauses are handled in super.

-- (I'm writing (¬¬q 4) instead of (q 4) here because otherwise super would pull
-- some tricks to produce intuitionist proofs.)
example (p q : ℕ → Prop) : p 3 → (∀x, p x → q (x+1)) → ¬¬q 4 := by do

trace "refutation problem:",
-- If we didn't already have a refutational problem, `as_refutation` would add
-- the double negation. In addition it does `intros`.
as_refutation,
trace_state,

trace "", trace "cnf:",
-- This step only parses the formula into clauses. They can still contain
-- propositional connectives--these are handled during preprocessing in the prover.
c1 ← get_local `a >>= clause.of_classical_proof,
c2 ← get_local `a_1 >>= clause.of_classical_proof,
c3 ← get_local `a_2 >>= clause.of_classical_proof,
trace [c1, c2, c3],

-- Whenever super generates a new clause in an inference, it immediately
-- generates a proof of it. To prevent the proof sizes from exploding
-- exponentially, super then uses `assert` to store the derived clause in the
-- local context, from then on we can refer to its proof via a local constant.

-- Hence each clause needs to have a type, the type of its proof. This type is
-- slightly ugly, but makes the implementation more uniform:
trace "", trace "actual type of the proof of the second clause:",
trace c2^.type,

-- We can now do the required resolution inferences by hand. Internally, the
-- `try_resolve` function instantiates the universal quantifiers with
-- meta-variables and then unifies the specified literals.
trace "", trace "two resolution inferences are required:",
c4 ← try_resolve trivial_term_order c1 c2 0 0,
trace c4,
c5 ← try_resolve trivial_term_order c4 c3 0 0,
trace c5,

-- We now have a proof of false (the type of the empty clause) and are done.
trace c5^.proof,
trace c5^.type,
exact c5^.proof
