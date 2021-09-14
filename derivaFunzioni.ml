open Lexing
open Parser
open Deriv

let espressioneInput = String.concat Sys.argv.(1) [""; "\n"];;

let _ =
      try
            let lexbuf = Lexing.from_string espressioneInput in
            let result = Parser.main Lexer.token lexbuf in
            Deriv.stampaEspressioneMath (Deriv.derivaEricombina result);
      with
       | DivisionByZero -> print_string "Error_DivisionByZero";;
