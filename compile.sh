#!/bin/sh

ocamlc -c deriv.ml

ocamllex lexer.mll       # generates lexer.ml
ocamlyacc parser.mly     # generates parser.ml and parser.mli
ocamlc -c parser.mli
ocamlc -c lexer.ml
ocamlc -c parser.ml

ocamlc -c outputLexer.ml
ocamlc -o outputLexer lexer.cmo parser.cmo outputLexer.cmo

ocamlc -c derivaFunzioni.ml
#ocamlc -o derivaFunzioni lexer.cmo parser.cmo deriv.cmo derivaFunzioni.cmo
ocamlc -custom -o derivaFunzioni lexer.cmo parser.cmo deriv.cmo derivaFunzioni.cmo


