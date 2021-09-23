(* File lexer.mll *)
(*
  Nell'header di questo file viene aperto il Parser, in quanto in esso è presente la definizione del tipo \emph{token}.
  Successivamente specifichiamo il nome dell’entrypoint con il nome “token”. 
  In seguito indichiamo tutte le espressioni regolari che possiamo incontrare con la relativa azione da svolgere, 
  in modo che venga prodotto l'output che sarà poi passato al parser.
*)

{
open Parser 
exception Eof
}
rule token = parse
	[' ' '\t']                          { token lexbuf }    (* salta caratteri vuoti *)
  | ['\n' ]                           { EOL }
  | ['0'-'9']+ as lxm                 { INT(int_of_string lxm) }
  | ['0'-'9']*'.'['0'-'9']+ as lxm    { FLOAT(float_of_string lxm) }
  | "log"                             { LOG }
  | "sin"                             { SIN }
  | "cos"                             { COS }
  | "tan"                             { TAN }
  | "cot"                             { COT }
  | "sec"                             { SEC }
  | "csc"                             { CSC }
  | ['x''X'] as lxm                   { VAR(String.make 1 lxm) }
  | '+'                               { PLUS }
  | '-'                               { MINUS }
  | '*'                               { TIMES }
  | '/'                               { DIV }
  | '^'                               { POWER }
  | '('                               { LPAREN }
  | ')'                               { RPAREN }
  | eof                               { EOF }