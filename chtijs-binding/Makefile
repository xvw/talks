all: slides

slides: compil.pdf functor.pdf
	pandoc \
          -st beamer \
          --variable classoption="aspectratio=169" \
	  -V theme:default \
	  slides.md -o slides.pdf

%.png : dot/%.dot
	dot -Tpng $(<) -o figures/$(@)

%.pdf : dot/%.dot
	dot -Tpdf $(<) -o figures/$(@)
