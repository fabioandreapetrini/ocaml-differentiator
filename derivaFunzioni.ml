open Lexing
open Parser
open Derivatore

let espressioneInput = String.concat Sys.argv.(1) [""; "\n"];;


 

let _ =
      try
            (* Lexing.from_string crea buffer lexer che legge una stringa di caratteri *)
            let lexbuf = Lexing.from_string espressioneInput in
            let result = Parser.main Lexer.token lexbuf in
            Derivatore.stampaEspressione (Derivatore.derivaEricombina result);
      with
       | DivisionByZero -> print_string "Error_DivisionByZero";;
