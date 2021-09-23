#!/bin/sh

ocamlc -c derivatore.ml

ocamllex lexer.mll       # genera lexer.ml
ocamlyacc parser.mly     # genera parser.ml e parser.mli
ocamlc -c parser.mli
ocamlc -c lexer.ml
ocamlc -c parser.ml

# Utilizzato, con finalità di debug, per controllare l'output del lexer
ocamlc -c outputLexer.ml
ocamlc -o outputLexer lexer.cmo parser.cmo outputLexer.cmo

ocamlc -c derivaFunzioni.ml

#ocamlc -o derivaFunzioni lexer.cmo parser.cmo derivatore.cmo derivaFunzioni.cmo

# L'opzione -custom permette di generare un eseguibile nella modalità runtime personalizzata.
# Il linker produce quindi un file di output che contiene sia il sistema runtime, sia il bytecode per il programma
# Il file risultante può essere così eseguito direttamente, senza la presenza del comando ocamlrun.
# Nel nostro caso è utile per poter effettuare il deploy dell'eseguibile nel server dov'è presente anche il front-end.
ocamlc -custom -o derivaFunzioni lexer.cmo parser.cmo derivatore.cmo derivaFunzioni.cmo
