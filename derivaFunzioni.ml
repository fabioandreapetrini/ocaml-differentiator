open Lexing
open Parser
open Deriv


let rec elaboraRisposte lexbuf1 =
  let result = Parser.main Lexer.token lexbuf1 in
          Deriv.stampaEspressioneMath (Deriv.deriva result);
          print_newline();
          print_newline(); 
          flush stdout;
          (* print_string lexbuf1.lex_buffer; *)
          elaboraRisposte lexbuf1



let _ =
  let filer = open_in Sys.argv.(1) in
    let lexbuf1 = Lexing.from_channel filer in
      elaboraRisposte lexbuf1;
      close_in filer;
      exit 0