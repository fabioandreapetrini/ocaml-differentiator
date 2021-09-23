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

open Derivatore

%start main             /* the entry point */

%type <Derivatore.espressione> main
%%
main:
    | espressione EOL 				{ $1 } 
;


espressione:
	| INT 															{ Derivatore.Costante (float_of_int $1) } 
	| FLOAT 														{ Derivatore.Costante $1 }	
	| INT espressione 									{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), $2) } 
	| FLOAT espressione 								{ Derivatore.Molt(Derivatore.Costante $1, $2) } 
	| VAR 															{ Derivatore.Variabile $1 }
	| espressione PLUS espressione 			{ Derivatore.Som($1, $3) } 
	| espressione MINUS espressione 		{ Derivatore.Diff($1, $3) } 
	| espressione TIMES espressione 		{ Derivatore.Molt($1, $3) } 
	| espressione DIV espressione 			{ Derivatore.Div($1, $3) } 
	| espressione POWER espressione 		{ Derivatore.Power($1, $3) } 
	| LPAREN espressione RPAREN 				{ $2 } 
	| LOG LPAREN espressione RPAREN			{ Derivatore.Logaritmo($3) }
	| SIN LPAREN espressione RPAREN			{ Derivatore.Seno($3) }
	| COS LPAREN espressione RPAREN			{ Derivatore.Coseno($3) }
	| TAN LPAREN espressione RPAREN			{ Derivatore.Tangente($3) }
	| COT LPAREN espressione RPAREN			{ Derivatore.Cotangente($3) }
	| SEC LPAREN espressione RPAREN			{ Derivatore.Secante($3) }
	| CSC LPAREN espressione RPAREN			{ Derivatore.Cosecante($3) }
	| MINUS espressione %prec UMINUS 		{ Derivatore.Diff(Derivatore.Costante 0.0, $2) }
;

