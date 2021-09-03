/* File parser.mly */
%token <int> INT
%token <float> FLOAT 
%token <string> VAR
%token PLUS MINUS TIMES DIV POWER
%token LPAREN RPAREN
%token EOL 
%token EOF 
%token LOG SIN COS TAN COT
%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%left POWER             /* medium precedence */
%nonassoc UMINUS        /* highest precedence */
%start main             /* the entry point */
%type <int> main
%%
main:
	expr EOL                { $1 }
;
expr:
	INT                     { $1 }
  | LPAREN expr RPAREN      { $2 }
  | expr PLUS expr          { $1 + $3 }
  | expr MINUS expr         { $1 - $3 }
  | expr TIMES expr         { $1 * $3 }
  | expr DIV expr           { $1 / $3 }
  | MINUS expr %prec UMINUS { - $2 }
;