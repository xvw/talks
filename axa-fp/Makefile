FIGURES = logic.pdf function.pdf divide.pdf mapreduce.pdf

all: $(FIGURES)
	xelatex slides.tex
	xelatex slides.tex

%.pdf: src/%.dot
	dot -Tpdf -o figures/$(@) $(<)
