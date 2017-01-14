sed 's|href="./\(.*\)lean"|href="https://leanprover.github.io/programming_in_lean/?url=https://github.com/leanprover/presentations/blob/master/20170116_POPL/\1lean\&live"|g' index.html > new_index.html
mv new_index.html index.html
