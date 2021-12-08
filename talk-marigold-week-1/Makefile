all: support.pdf

%.pdf : %.md
	pandoc -t beamer  -V theme:default -V aspectratio:169 $(<) -o $(@)

clean:
	rm *.pdf

ml:
	dune build
