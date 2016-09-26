import data.vector data.list
open nat list vector

variable {A : Type}

definition to_list [coercion] : ∀ {n : nat}, vector A n → list A
| 0      nil    := nil
| (n+1)  (a::v) := a::(to_list v)
