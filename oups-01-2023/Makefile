all: support.pdf

%.pdf : %.md
	pandoc -t beamer -f markdown+implicit_figures -V theme:default -V aspectratio:169 $(<) -o $(@)

clean:
	rm *.pdf
