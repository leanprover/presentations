import system.io

set_option native.binary "hello"

def main : io unit :=
    put_str_ln "Hello Lean!"
