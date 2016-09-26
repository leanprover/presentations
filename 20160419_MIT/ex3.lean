import data.prod data.list
open nat prod list

eval default (nat → nat × list nat × Prop)

definition myval [instance] : inhabited nat :=
inhabited.mk 10

eval default (nat → nat × list nat × Prop)
