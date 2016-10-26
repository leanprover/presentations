namespace hide
universe variable u
constant list : Type u → Type u

namespace list
  constant cons : Π {A : Type u}, A → list A → list A
  constant nil : Π {A : Type u}, list A
  constant append : Π {A : Type u}, list A → list A → list A
end list

open hide.list

variable  A : Type
variable  a : A
variables l1 l2 : list A

check cons a nil
check append (cons a nil) l1
check append (append (cons a nil) l1) l2

set_option pp.implicit true

check cons a nil
check append (cons a nil) l1
check append (append (cons a nil) l1) l2

end hide
