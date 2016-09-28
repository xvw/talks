ocamljs = ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.syntax -syntax camlp4o -linkpkg
all: run

run: js
	cd sample && make test.byte &
	iceweasel index.html

kill:
	killall ocsigenserver

js:
	$(ocamljs) -o nukislider.byte nukislider.ml
	js_of_ocaml -o nukislider.js nukislider.byte
