# Why
This is an introductory course for using git, in French, given at Polytech Lille, part of the University of Lille.

# Dependencies

`minted` <http://mirror.utexas.edu/ctan/macros/latex/contrib/minted/minted.pdf>

inkscape

# Compiling

~~`lualatex -synctex=1 -interaction=nonstopmode -shell-escape slides.tex`~~

`make`

## `pdflatex` vs `lualatex`

The makefile uses `lualatex` but the document does compile with `pdflatex` also.

If you need to use pdflatex, you should uncomment the line `%\usepackage[utf8]{inputenc}` in `CM-preamble.sty` which fixes issues with utf characters.

