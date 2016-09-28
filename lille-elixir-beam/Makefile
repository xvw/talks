ocamljs = ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.ppx -linkpkg
all: js

js:
	$(ocamljs) -o nukislider.byte nukislider.ml
	js_of_ocaml -o nukislider.js nukislider.byte
	rm -rf *.byte *.cm*
