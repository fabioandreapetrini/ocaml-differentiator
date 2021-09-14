(*file outputLexer.ml*)
open Lexing
open Parser
let print_token = function 
    | INT n -> print_string "INT "; print_int n; print_newline()
    | FLOAT n -> print_string "FLOAT "; print_float n; print_newline()
    | VAR n -> print_string "VAR "; print_string n; print_newline()
    | PLUS -> print_string " PLUS"; print_newline()
    | MINUS -> print_string "MINUS "; print_newline()
    | TIMES -> print_string "TIMES "; print_newline()
    | DIV -> print_string "DIV "; print_newline()
    | POWER -> print_string "POWER "; print_newline()
    | LPAREN -> print_string " LPAREN"; print_newline()
    | RPAREN -> print_string "RPAREN "; print_newline()
    | LOG -> print_string "LOG "; print_newline()
    | SIN -> print_string "SIN "; print_newline()
    | COS -> print_string "COS "; print_newline()
    | TAN -> print_string "TAN "; print_newline()
    | COT -> print_string "COT "; print_newline()
    | SEC -> print_string "SEC "; print_newline()
    | CSC -> print_string "CSC "; print_newline()
    | EOL -> print_string "EOL "; print_newline()
    | EOF -> print_string "EOF "; print_newline()



let rec elaboraRisposte lexbuf1 =
  let result = Lexer.token lexbuf1 in
    print_token result;
    print_newline();
    (* print_string lexbuf1.lex_buffer; *)
    flush stdout;
    match result with
      | EOF -> ()
      | _ -> elaboraRisposte lexbuf1


let _ =
  let filer = open_in Sys.argv.(1) in
    let lexbuf1 = Lexing.from_channel filer in
      elaboraRisposte lexbuf1;
      close_in filer;
      exit 0
