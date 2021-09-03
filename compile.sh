#!/bin/sh

ocamllex lexer.mll       # generates lexer.ml
ocamlyacc parser.mly     # generates parser.ml and parser.mli
ocamlc -c parser.mli
ocamlc -c lexer.ml
ocamlc -c parser.ml

ocamlc -c outputLexer.ml
ocamlc -o outputLexer lexer.cmo parser.cmo outputLexer.cmo

ocamlc -c deriv.ml
ocamlc -o deriv lexer.cmo parser.cmo outputLexer.cmo deriv.cmo



