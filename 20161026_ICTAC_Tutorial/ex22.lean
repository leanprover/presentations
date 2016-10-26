namespace hide

universe variable u

constant list : Type u → Type u

constant cons : Π A : Type u, A → list A → list A
constant nil : Π A : Type u, list A
constant head : Π A : Type u, list A → A
constant tail : Π A : Type u, list A → list A
constant append : Π A : Type u, list A → list A → list A

end hide
