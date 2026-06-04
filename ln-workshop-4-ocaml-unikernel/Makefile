# Only for building slides

all: slides

slides: slides.md
	pandoc -o slides.pdf \
               -t beamer -V theme:default -V aspectratio:169 \
               slides.md
