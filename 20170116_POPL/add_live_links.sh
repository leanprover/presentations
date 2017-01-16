mv new_index.html index.html
perl -pe 's|href="./(.*?)lean">(.*?)</a>|<a href="https://github.com/leanprover/presentations/blob/master/20170116_POPL/\1lean">\2</a> <a href="https://leanprover.github.io/programming_in_lean/?url=https://github.com/leanprover/presentations/blob/master/20170116_POPL/\1lean\&live">[live]</a>|g' index.html > new_index.html
