Backward chaining
==================

- [back.lean](back.lean): A simple Lean tactic for list membership goals
  using backward chaining.

- [back_trace.lean](back_trace.lean): Add tracing to the previous tactic.

- [back_inplace.lean](back_inplace.lean): The same example implemeted
  on top of the `apply` tactic.

- [builtin.lean](builtin.lean): Same example using the builtin backward
  chaining tactic.

- [ematch.lean](ematch.lean): Same example using heuristic instantiation.

This example is also used to demonstrate the [superposition theorem prover](../super) implemented in Lean.
