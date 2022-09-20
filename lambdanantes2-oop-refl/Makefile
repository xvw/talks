.PHONY: all clean ml fig

all: slides.pdf ml

%.pdf : %.md Makefile fig
	pandoc -t beamer  -V theme:default --highlight=pygments -V aspectratio:169 $(<) -o $(@)

clean:
	rm *.pdf
	dune clean

ml:
	dune build

qrcode:
	dune exec sandbox/qrcode.exe

fig/%.pdf: fig/%.tex
	pdflatex -output-directory=fig $(<)

images/%.png: fig/%.pdf
	convert -density 100 $(<) -quality 90 $(@)

fig: images/product.png images/product-elim.png
