# BASE PDF FILES
LATEX_COMPILER = lualatex

# Default rule
#all: 1pp 2pp 4pp 6pp TPGit CheatSheets
#2pp doesn't work well for slides.
all: 1pp 4pp 6pp 8pp TPGit PDFs/git_bash_markdown-2pp.pdf slides/slides.pdf

base = slides/slides.pdf
base: ${base}

slides/slides.pdf: slides/slides.tex images slides/CM-preamble.sty
	cd slides; $(LATEX_COMPILER) -shell-escape -interaction=nonstopmode slides.tex

# IMAGES
images: $(patsubst images/%.svg,images/%.pdf,$(wildcard images/*.svg))

images/%.pdf: images/%.svg
	inkscape --export-type=pdf "$@" "$<"

#CheatSheets: PDFs/git_bash_markdown.pdf
PDFs/git_bash_markdown-2pp.pdf: PDFs/git_bash_markdown.pdf
	cd PDFs; $(LATEX_COMPILER) CM-handouts-2pp.tex git_bash_markdown.pdf
	mv PDFs/CM-handouts-2pp.pdf PDFs/git_bash_markdown-2pp.pdf

TPGit: TPGit/TPGit.pdf PDFs/TPGit-2pp.pdf
TPGit/TPGit.pdf: TPGit/TPGit.tex images
	cd TPGit; $(LATEX_COMPILER) -shell-escape -interaction=nonstopmode TPGit.tex
PDFs/TPGit-2pp.pdf: TPGit/TPGit.pdf
	cd PDFs; cp ../TPGit/TPGit.pdf . ; $(LATEX_COMPILER) CM-handouts-2pp.tex TPGit.pdf
	mv PDFs/CM-handouts-2pp.pdf PDFs/TPGit-2pp.pdf

# PDFs
# 1 slide / page
1pp = $(addprefix PDFs/,$(filter %.pdf,$(subst /, ,${base})))
1pp: ${1pp}
2pp: $(patsubst %.pdf,%-handouts-2pp.pdf,${1pp})
# 4 slides / page
4pp: $(patsubst %.pdf,%-handouts-4pp.pdf,${1pp})
# 6 slides / page
6pp: $(patsubst %.pdf,%-handouts-6pp.pdf,${1pp})
8pp: $(patsubst %.pdf,%-handouts-8pp.pdf,${1pp})

# Where to search for PDF files in the following rules
vpath %.pdf $(wildcard slides*)

PDFs/%-handouts-2pp.pdf: %.pdf
	cd PDFs; $(LATEX_COMPILER) CM-handouts-2pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-2pp.pdf "$@"
	

PDFs/%-handouts-4pp.pdf: %.pdf
	cd PDFs; $(LATEX_COMPILER) CM-handouts-4pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-4pp.pdf "$@"

PDFs/%-handouts-6pp.pdf: %.pdf
	cd PDFs; $(LATEX_COMPILER) CM-handouts-6pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-6pp.pdf "$@"

PDFs/%-handouts-8pp.pdf: %.pdf
	cd PDFs; $(LATEX_COMPILER) CM-handouts-8pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-8pp.pdf "$@"

PDFs/%.pdf: %.pdf
	cp "$<" "$@"

#PDFs/slides.pdf: slides.pdf
#	cp "$<" "$@"

clean:
	rm -fv images/*.pdf
	#rm -fv PDFs/*.pdf PDFs/*.log PDFs/*.aux
	rm -fv PDFs/*.log PDFs/*.aux
	rm -rfv CM*/*_minted-*
	rm -fv slides/slides.pdf slides/*.log slides/*.aux slides/*.nav slides/*.snm slides/*.toc slides/*.vrb

clean-all-pdfs: clean
	rm -fv PDFs/*.pdf

# Rules that do not represent a file
.PHONY: base 1pp 2pp 4pp 6pp 8pp clean

