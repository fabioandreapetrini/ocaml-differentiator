(*
	In questo file abbiamo prima dichiarato i diversi simboli come Token, tra i quali quelli relativi alle variabili 
	e costanti di tipo intero e float e simboli relativi alle funzioni/operazioni utilizzate. 
*)

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
	| INT VAR 																										{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Variabile $2) } 
	| FLOAT VAR 																									{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Variabile $2) } 
	| INT LOG LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Logaritmo ($4)) } 
	| FLOAT LOG LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Logaritmo ($4)) } 
	| INT SIN LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Seno ($4)) } 
	| FLOAT SIN LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Seno ($4)) } 
	| INT COS LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Coseno ($4)) } 
	| FLOAT COS LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Coseno ($4)) } 
	| INT TAN LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Tangente ($4)) } 
	| FLOAT TAN LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Tangente ($4)) } 
	| INT COT LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Cotangente ($4)) } 
	| FLOAT COT LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Cotangente ($4)) } 
	| INT SEC LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Secante ($4)) } 
	| FLOAT SEC LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Secante ($4)) } 
	| INT CSC LPAREN espressione RPAREN 													{ Derivatore.Molt(Derivatore.Costante (float_of_int $1), Derivatore.Cosecante ($4)) } 
	| FLOAT CSC LPAREN espressione RPAREN 												{ Derivatore.Molt(Derivatore.Costante $1, Derivatore.Cosecante ($4)) } 
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

