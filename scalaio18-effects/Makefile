all: slides

slides:
	pandoc \
          -st beamer \
          --variable classoption="aspectratio=169" \
	  -V theme:metropolis \
	  slides.md -o slides.pdf

%.png : dot/%.dot
	dot -Tpng $(<) -o figures/$(@)

%.pdf : dot/%.dot
	dot -Tpdf $(<) -o figures/$(@)
