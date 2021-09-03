(* File lexer.mll *)
{
open Parser        
exception Eof
}
rule token = parse
	[' ' '\t']                          { token lexbuf }    
  | ['\n' ]                           { EOL }
  | ['0'-'9']+ as lxm                 { INT(int_of_string lxm) }
  | ['0'-'9']*'.'['0'-'9']+ as lxm    { FLOAT(float_of_string lxm) }
  | "log"                             { LOG }
  | "sin"                             { SIN }
  | "cos"                             { COS }
  | "tan"                             { TAN }
  | "cot"                             { COT }
  | ['a'-'z''A'-'Z']['a'-'z''A'-'Z''0'-'9''_']* as lxm { VAR(lxm) }
  | '+'                               { PLUS }
  | '-'                               { MINUS }
  | '*'                               { TIMES }
  | '/'                               { DIV }
  | '^'                               { POWER }
  | '('                               { LPAREN }
  | ')'                               { RPAREN }
  | eof                               { EOF }