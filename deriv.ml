type expr =
    Costante of float
  | Variabile of string
  | Som of expr * expr
  | Diff of expr * expr
  | Molt of expr * expr
  | Div of expr * expr 
  | Power of expr * expr
  | Seno of expr
  | Coseno of expr
  | Tangente of expr
  | Cotangente of expr
  | Secante of expr
  | Cosecante of expr 
  | Logaritmo of expr;;


let rec deriva = function
    Costante n -> Costante(0.0)
  | Variabile x -> Costante(1.0)
  | Som(e1,e2) -> Som(deriva e1, deriva e2 )
  | Diff(e1,e2) -> Diff(deriva e1, deriva e2 )
  | Molt(e1,e2) -> Som( Molt(deriva e1, e2), Molt(e1, deriva e2) )
  | Div(e1,e2) -> Div( Diff( Molt(deriva e1, e2), Molt(e1, deriva e2)), Power(e2, Costante(2.0)))
  | Power(e1, Costante(a) ) -> Molt( Costante(a), Power(e1, (Costante(a -. 1.0))) )
  | Power(Costante(a), e1) ->  Molt( Power(Costante(a),e1), Logaritmo(Costante(a) ) )
  | Power(e1, e2) -> Molt( Power(e1,e2), Som(Logaritmo(e1), Costante(1.0) ) )
  | Logaritmo(e1) -> Div( Costante(1.0), e1)
  | Seno(e1) -> Coseno(e1)
  | Coseno(e1) -> Molt( Costante(-1.0), Seno(e1) )
  | Tangente(e1) -> Div ( Costante(1.0), Power ( Coseno(e1), Costante(2.0)))
  | Cotangente(e1) -> Div ( Costante(-1.0), Power ( Seno(e1), Costante(2.0)))
  | _ -> Costante(0.0);;
  

(* Conversione delle espressioni da expression a string *)
let print_expr exp =
	let rec print exp =
		match exp with
		| Costante c -> string_of_float(c)
		| Variabile v -> v
		| Som(f, g) -> "(" ^ (print f) ^ " + " ^ (print g) ^ ")";
		| Diff(f, g) -> "(" ^ (print f) ^ " - " ^ (print g) ^ ")";
		| Molt(f, g) -> "(" ^ (print f) ^ " * " ^ (print g) ^ ")";
		| Div(f, g) -> "(" ^ (print f) ^ " / " ^ (print g) ^ ")";
		| Power(f, e) -> "" ^ (print f) ^ "^(" ^ print(e) ^ ")";
		| Logaritmo(f) -> "ln(" ^ (print f) ^ ")";
		| Seno(f) -> "sin(" ^ (print f) ^ ")";
		| Coseno(f) -> "cos(" ^ (print f) ^ ")";
		| Tangente(f) -> "tan(" ^ (print f) ^ ")";
		| Cotangente(f) -> "cot(" ^ (print f) ^ ")";
		| _ -> "erorr";
	in print exp;;

  let a_string = "ciao";;
  Printf.printf "Debug: %s\n" a_string;


