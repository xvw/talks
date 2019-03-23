all: slides

slides: a.svg b.svg
	pandoc -o slides.pdf -t beamer slides.org \
	  --highlight-style=espresso \
	  --pdf-engine=xelatex -st beamer

%.svg: dot/%.dot
	dot -Tsvg \
	  -Nfontsize=8 -Nfontcolor="#137A86" \
	  -Efontsize=10 -Efontcolor="#137A86" \
	  -Ncolor="#137A86" -Ecolor="#137A86" \
	  $(<) -o fig/$(@) 
