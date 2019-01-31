all: slides

slides: compil.pdf functor.pdf
	pandoc \
          -st beamer \
	  -V theme:default \
	  slides.md -o slides.pdf

%.png : dot/%.dot
	dot -Tpng $(<) -o figures/$(@)

%.pdf : dot/%.dot
	dot -Tpdf $(<) -o figures/$(@)
