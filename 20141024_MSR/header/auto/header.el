(TeX-add-style-hook
 "header"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("luainputenc" "utf8") ("xcolor" "dvipsnames" "table") ("glossaries" "acronym" "toc") ("adjustbox" "export")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (TeX-run-style-hooks
    "Glossary"
    "luainputenc"
    "amsmath"
    "mathspec"
    "unixode"
    "amssymb"
    "fontspec"
    "microtype"
    "setspace"
    "etoolbox"
    "csquotes"
    "ulem"
    "minted"
    "xcolor"
    "glossaries"
    "makeidx"
    "polyglossia"
    "xparse"
    "float"
    "rotating"
    "array"
    "calc"
    "framed"
    "wrapfig"
    "longtable"
    "adjustbox"
    "tikz"
    "blindtext"
    "geometry"
    "titlesec")
   (TeX-add-symbols
    '("inputc" TeX-arg-file)
    '("inputlatex" TeX-arg-file)
    '("makenewmintedfiles" 1)
    "xor"
    "illustration"
    "advanced"
    "args")
   (LaTeX-add-labels
    "#4")
   (LaTeX-add-environments
    "exercise")
   (LaTeX-add-lengths
    "drop")))

