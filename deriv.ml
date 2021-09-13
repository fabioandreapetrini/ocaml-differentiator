exception DivisionByZero;;

type expr =
  None
  |  Costante of float
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
  | Logaritmo of expr;;



let rec deriva = function
    Costante n -> Costante(0.0)
  | Variabile x -> Costante(1.0)
  | Som(e1,e2) -> Som(deriva e1, deriva e2 )
  | Diff(e1,e2) -> Diff(deriva e1, deriva e2 )
  | Molt(e1,e2) -> Som( Molt(deriva e1, e2), Molt(e1, deriva e2) )
  | Div(e1,e2) -> Div( Diff( Molt(deriva e1, e2), Molt(e1, deriva e2)), Power(e2, Costante(2.0)))
  | Power(e1, Costante(a) ) -> Molt( Costante(a),   Molt(deriva e1, Power(e1, (Costante(a -. 1.0)))))       
  | Power(Costante(a), e1) ->  Molt(deriva e1, Molt(Power(Costante(a),e1), Logaritmo(Costante(a))))
  | Power(e1, e2) -> Molt(Power(e1,e2), Som(Molt(deriva e2, Logaritmo(e1)), Div(Molt(e2, deriva e1), e1 )))
  | Logaritmo(e1) -> Molt(deriva e1, Div( Costante(1.0), e1))
  | Seno(e1) -> Molt(Coseno(e1), deriva e1)
  | Coseno(e1) -> Molt( Costante(-1.0), Molt(deriva e1, Seno(e1)))
  | Tangente(e1) -> Molt(deriva e1, Div ( Costante(1.0), Power ( Coseno(e1), Costante(2.0))))
  | Cotangente(e1) -> Molt(deriva e1, Div ( Costante(-1.0), Power ( Seno(e1), Costante(2.0))))
  | _ -> Costante(0.0);;
  

let rec stampaEspressioneMath = function
  | Costante x ->     Printf.printf "%.*f" 2 x;
  | Variabile x ->    print_string x;
  | Som(e1,e2) ->     print_string "("; stampaEspressioneMath e1;  print_string " + "; stampaEspressioneMath e2; print_string ")";
  | Diff(e1,e2) ->    print_string "("; stampaEspressioneMath e1;  print_string " - "; stampaEspressioneMath e2; print_string ")";
  | Molt (e1,e2) ->   print_string "("; stampaEspressioneMath e1;  print_string " * "; stampaEspressioneMath e2; print_string ")";
  | Div (e1,e2) ->    print_string "("; stampaEspressioneMath e1;  print_string " / "; stampaEspressioneMath e2; print_string ")";   
  | Power (e1,e2) ->  print_string "("; stampaEspressioneMath e1;  print_string "^"; stampaEspressioneMath e2; print_string ")";      
  | Seno e ->         print_string " sin(";  stampaEspressioneMath e;   print_string ")"
  | Coseno e ->       print_string " cos(";  stampaEspressioneMath e;   print_string ")"
  | Tangente e ->     print_string " tan(";  stampaEspressioneMath e;   print_string ")"
  | Cotangente e ->   print_string " cot(";  stampaEspressioneMath e;   print_string ")"
  | Logaritmo e ->    print_string " log(";  stampaEspressioneMath e;   print_string ")"
  | _ -> print_string "null";;


(* Riduce parzialmente il risultato finale *)
let rec ricombina = function
	| Molt(Costante a, Costante b) -> Costante (a *. b)
	| Molt(e, Costante b) ->
		if (b = 0.0) then 
      (Costante 0.0)
		else if (b = 1.0) then 
      ricombina e
		else 
      Molt(ricombina e, Costante b)
	| Molt(Costante a, e) ->
		if (a = 0.0) then 
      (Costante 0.0)
		else if (a = 1.0) then 
      ricombina e
		else 
      Molt(Costante a, ricombina e)
	| Molt(e1, e2) -> Molt(ricombina e1, ricombina e2)


	| Div (Costante a, Costante b) ->
		if (b = 0.0) then 
      raise DivisionByZero
		else 
      Costante (a /. b)
	| Div(e, Costante b) ->
		if (b = 0.0) then 
      raise DivisionByZero;
		if (b = 1.0) then 
      ricombina e
		else 
      Div(ricombina e, Costante b)
	| Div(Costante a, e) -> Div(Costante a, ricombina e)
	| Div(e1, e2) -> Div(ricombina e1, ricombina e2)


	| Diff(Costante a, Costante b) -> Costante(a -. b)
	| Diff(e, Costante b) ->
		if (b = 0.0) then 
      ricombina e
		else 
      Diff(ricombina e, Costante b)
	| Diff(Costante a, e) -> Diff(Costante a, ricombina e)
	| Diff(e1, e2) -> Diff(ricombina e1, ricombina e2)


	| Som(Costante a, Costante b) -> Costante(a +. b)
	| Som(e, Costante b) ->
		if (b = 0.0) then 
      ricombina e
		else 
      Som(ricombina e, Costante b)
	| Som(Costante a, e) ->
		if (a = 0.0) then 
      ricombina e
		else 
      Som(Costante a, ricombina e)
	| Som(e1, e2) -> Som(ricombina e1, ricombina e2)


	| Power(Costante a, Costante b) -> Costante(a ** b)
	| Power(e, Costante b) ->
		if (b = 0.0) then 
      (Costante 1.0)
		else if (b = 1.0) then 
      ricombina e
		else 
      Power (ricombina e, Costante b)
	| Power(Costante a, e) -> 
		if (a = 0.0) then 
      (Costante 0.0)
		else if (a = 1.0) then 
      ricombina e
		else 
      Power(Costante a, ricombina e)
	| Power(e1, e2) -> Power(ricombina e1, ricombina e2)

	| Logaritmo(e) -> Logaritmo(ricombina e)
	| Coseno(e1) -> Coseno(ricombina e1)
	| Seno(e1) -> Seno(ricombina e1)
	| Tangente(e1) -> Tangente(ricombina e1)
	| Cotangente(e1) -> Cotangente(ricombina e1)
	| Costante c -> Costante c
	| Variabile x -> Variabile x
;;

(*funzione per fare il ricombina fino a quando è possibile*)
let rec ricombina_tutto exp aux=
  if (exp = aux) then exp
  else (ricombina_tutto (ricombina exp) exp);;

(*funzione che richiama il ricombina_tutto correttamente*)
let ricombina_tutto_quanto exp=
  ricombina_tutto (ricombina exp) exp;;

(*funzione che fa la derivata e poi ricombina*)
let derivaEricombina exp =
  ricombina_tutto_quanto (deriva exp);;