all: slides

slides:
	pandoc -o slides.pdf -t beamer slides.org \
	  --pdf-engine=xelatex -st beamer

%.svg: dot/%.dot
	dot -Tsvg \
          -Nfontname=Roboto -Nfontsize=8 -Nfontcolor="#137A86" \
	  -Efontname=Roboto -Efontsize=10 -Efontcolor="#137A86" \
	  -Ncolor="#162349" -Ecolor="#031A23" \
	  $(<) -o fig/$(@) 
