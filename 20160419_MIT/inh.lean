open inhabited

definition default_2 (A : Type) [h : inhabited A] : A :=
match h with
| mk a := a
end
