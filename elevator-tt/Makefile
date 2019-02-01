all: slides

slides: a.svg b.svg c.svg d.svg e.svg
	pandoc -o slides.pdf -t beamer slides.org \
	  --pdf-engine=xelatex \
	  -st beamer --variable classoption="aspectratio=169" \
	  -V theme:Boadilla

%.svg: dot/%.dot
	dot -Tsvg \
          -Nfontname=Roboto -Nfontsize=8 -Nfontcolor="#162349" \
	  -Efontname=Roboto -Efontsize=10 -Efontcolor="#162349" \
	  -Ncolor="#162349" -Ecolor="#162349" \
	  $(<) -o fig/$(@) 
