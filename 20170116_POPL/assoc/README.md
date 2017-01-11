Flattening nested applications of associative operators
=======================================================

- [builtin_ac.lean](builtin_ac.lean): Lean has builtin support for associative commutative operators,
  but this is not the point of this mini tutorial.

- [flat_assoc.lean](flat_assoc.lean): In this example, we demonstrate how to write
  a tactic to "flat" nested applications of associative operators. This tactic
  uses only the basic primitives, and does not rely on the Lean simplifier.

- [flat_assoc_trace.lean](flat_assoc_trace.lean): In this example, we show
  how to "trace" the execution of the tactic built in the previous example.

- [ac_by_simp.lean](ac_by_simp.lean): it demonstrates different ways to
  use the Lean simplifier. In particular, we build a tactic for "sorting"
  nested applications of associative/commutative operators.
