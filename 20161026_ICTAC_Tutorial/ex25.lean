namespace hide
universe variable u
constant list : Type u → Type u

namespace list
  constant cons : Π (A : Type u), A → list A → list A
  constant nil : Π (A : Type u), list A
  constant append : Π (A : Type u), list A → list A → list A
end list

open hide.list

variable  a : nat
variables l1 l2 : list nat

check cons nat a (nil nat)
check append nat (cons nat a (nil nat)) l1
check append nat (append nat (cons nat a (nil nat)) l1) l2

check cons _ a (nil _)
check append _ (cons _ a (nil _)) l1
check append _ (append _ (cons _ a (nil _)) l1) l2

end hide
