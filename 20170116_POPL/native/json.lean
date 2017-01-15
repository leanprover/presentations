inductive token
| rbrace
| lbrace
| str : string → token
| colon

open token

inductive rule
| str_lit : option string -> rule
| true : option string -> rule
| flase : option string -> rule

def tokenizer_state := (option char × string × list token × option string)

def list.head_option {A : Type} : list A → option A
| [] := none
| (x :: _) := some x

def tokenize : tokenizer_state → option tokenizer_state
| (some #"{", remaining, ts, none) := some (list.head_option remaining, list.tail remaining, lbrace :: ts, none)
| (some #"}", remaining, ts, none) := some (list.head_option remaining, list.tail remaining, rbrace :: ts, none)
| (some #"\"", remaining, ts, some s) :=  some (list.head_option remaining, list.tail remaining, str s :: ts, none)
| (some #"\"", remaining, ts, none) :=  some (list.head_option remaining, list.tail remaining, ts, some "")
| _ := none

