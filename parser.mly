/* File parser.mly */
%token <int> INT
%token <float> FLOAT 
%token <string> VAR
%token PLUS MINUS TIMES DIV POWER
%token LPAREN RPAREN
%token EOL 
%token EOF 
%token LOG SIN COS TAN COT CSC SEC
%left PLUS MINUS        /* lowest precedence */
%left TIMES DIV         /* medium precedence */
%left POWER             /* medium precedence */
%nonassoc UMINUS        /* highest precedence */

open Deriv

%start main             /* the entry point */

%type <Deriv.expr> main
%%
main:
    | expr EOL 				{ $1 } 
;


expr:
	| INT 															{ Deriv.Costante (float_of_int $1) } 
	| FLOAT 														{ Deriv.Costante $1 }	
	| INT expr 													{ Deriv.Molt(Deriv.Costante (float_of_int $1), $2) } 
	| FLOAT expr 												{ Deriv.Molt(Deriv.Costante $1, $2) } 
	| VAR 															{ Deriv.Variabile $1 }
	| expr PLUS expr 										{ Deriv.Som($1, $3) } 
	| expr MINUS expr 									{ Deriv.Diff($1, $3) } 
	| expr TIMES expr 									{ Deriv.Molt($1, $3) } 
	| expr DIV expr 										{ Deriv.Div($1, $3) } 
	| expr POWER expr 									{ Deriv.Power($1, $3) } 
	| LPAREN expr RPAREN 								{ $2 } 
	| LOG LPAREN expr RPAREN						{ Deriv.Logaritmo($3) }
	| SIN LPAREN expr RPAREN						{ Deriv.Seno($3) }
	| COS LPAREN expr RPAREN						{ Deriv.Coseno($3) }
	| TAN LPAREN expr RPAREN						{ Deriv.Tangente($3) }
	| COT LPAREN expr RPAREN						{ Deriv.Cotangente($3) }
	| SEC LPAREN expr RPAREN						{ Deriv.Secante($3) }
	| CSC LPAREN expr RPAREN						{ Deriv.Cosecante($3) }
	| MINUS expr %prec UMINUS 					{ Deriv.Diff(Deriv.Costante 0.0, $2) }
;

