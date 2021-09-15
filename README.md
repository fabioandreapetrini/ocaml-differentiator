# Ocaml Differentiator
Ocaml software that allows you to calculate the derivative of a function in a real variable.

## Getting Started 
### Installing

If you have bash, run script compile.sh or run the following commands: 

```javascript
ocamlc -c deriv.ml

ocamllex lexer.mll       # generates lexer.ml
ocamlyacc parser.mly     # generates parser.ml and parser.mli
ocamlc -c parser.mli
ocamlc -c lexer.ml
ocamlc -c parser.ml

ocamlc -c outputLexer.ml
ocamlc -o outputLexer lexer.cmo parser.cmo outputLexer.cmo

ocamlc -c derivaFunzioni.ml
ocamlc -custom -o derivaFunzioni lexer.cmo parser.cmo deriv.cmo derivaFunzioni.cmo
```
copy ```derivaFunzioni``` to your web server and make it executable from it.

edit ```config.php``` with path of ```derivaFunzioni``` and copy it with all others files of the web directory in your document root.

Enjoy!


### Exames:

Artificial Intelligence - Intelligent Application Development
(Università degli Studi di Perugia)

### Students:

Fabio Andrea Petrini
Matteo Baldassarrini

