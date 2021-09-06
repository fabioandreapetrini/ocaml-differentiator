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

open Deriv

%start main             /* the entry point */

%type <Deriv.expr> main
%%
main:
    expr EOL                { $1 }
;

expr:
	| INT { Deriv.Costante (float_of_int $1) } 
	| FLOAT { Deriv.Costante $1 }	
;