all: slides

slides: parsing.svg ast.svg
	pandoc -o slides.pdf -t beamer slides.org \
	  --pdf-engine=xelatex -st beamer

tex:
	pandoc -o slides.tex -t beamer slides.org \
	  --pdf-engine=xelatex -st beamer


%.svg: dot/%.dot
	dot -Tsvg \
	  -Nfontsize=8 -Nfontcolor="#137A86" \
	  -Efontsize=10 -Efontcolor="#137A86" \
	  -Ncolor="#137A86" -Ecolor="#137A86" \
	 $(<) -o fig/$(@) 
