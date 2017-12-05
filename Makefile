# BASE PDF FILES

# Default rule
all: 1pp 4pp 6pp

base = slides/slides.pdf
base: ${base}

slides/slides.pdf: images
	cd slides; lualatex -shell-escape -interaction=nonstopmode slides.tex

# IMAGES
images: $(patsubst images/%.svg,images/%.pdf,$(wildcard images/*.svg))

images/%.pdf: images/%.svg
	inkscape -A "$@" "$<"

# PDFs 
# 1 slide / page
1pp = $(addprefix PDFs/,$(filter %.pdf,$(subst /, ,${base})))
1pp: ${1pp}
# 4 slides / page
4pp: $(patsubst %.pdf,%-handouts-4pp.pdf,${1pp})
# 6 slides / page
6pp: $(patsubst %.pdf,%-handouts-6pp.pdf,${1pp})

# Where to search for PDF files in the following rules
vpath %.pdf $(wildcard slides*)

PDFs/%-handouts-4pp.pdf: %.pdf
	cd PDFs; pdflatex CM-handouts-4pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-4pp.pdf "$@"

PDFs/%-handouts-6pp.pdf: %.pdf
	cd PDFs; pdflatex CM-handouts-6pp.tex "$(shell basename "$<")"
	mv PDFs/CM-handouts-6pp.pdf "$@"

PDFs/%.pdf: %.pdf
	cp "$<" "$@"

#PDFs/slides.pdf: slides.pdf
#	cp "$<" "$@"

clean:
	rm -fv images/*.pdf
	rm -fv PDFs/*.pdf PDFs/*.log PDFs/*.aux
	rm -rfv CM*/*_minted-*
	rm -fv slides/slides.pdf slides/*.log slides/*.aux slides/*.nav slides/*.snm slides/*.toc slides/*.vrb

# Rules that do not represent a file
.PHONY: base 1pp 4pp 6pp clean


