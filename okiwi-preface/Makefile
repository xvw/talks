all: support

support: support.md
	pandoc \
          -st beamer \
	  -V theme:default -V aspectratio:169 \
	  support.md -o support.pdf
