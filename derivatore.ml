exception DivisionByZero;;

(* 
   Definisce il tipo espressione attraverso l'unione di diversi tipi associati al rispettivo costruttore 
*)
type espressione =
   Costante of float
  | Variabile of string
  | Som of espressione * espressione
  | Diff of espressione * espressione
  | Molt of espressione * espressione
  | Div of espressione * espressione 
  | Power of espressione * espressione
  | Seno of espressione
  | Coseno of espressione
  | Tangente of espressione
  | Cotangente of espressione
  | Secante of espressione
  | Cosecante of espressione
  | Logaritmo of espressione;;


(* 
   Funzione che deriva l'espressione. 
   Si tratta di una funzione ricorsiva che prende in input una variabile di tipo espressione, utilizzando il pattern matching per discrimanere i diversi tipi,
   al fine di restituire l'espressione derivata.
*)
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
  | Secante(e1) -> Molt(deriva e1, Molt(Secante(e1), Tangente(e1)))
  | Cosecante(e1) -> Molt(deriva e1, Molt(Molt(Costante(-1.0), Cotangente(e1) ), Cosecante(e1)))
  | Tangente(e1) -> Molt(deriva e1, Div ( Costante(1.0), Power ( Coseno(e1), Costante(2.0))))
  | Cotangente(e1) -> Molt(deriva e1, Div ( Costante(-1.0), Power ( Seno(e1), Costante(2.0))))
  | _ -> Costante(0.0);;
  


(*
   Stampa l'espressione in formato leggibile dall'essere umano.
*)
let rec stampaEspressione = function
  | Costante x ->     
      if (float_of_int(int_of_float(x)) = x) then
        print_int (int_of_float(x))
      else 
        Printf.printf "%.*f" 2 x;
  | Variabile x ->    print_string x;
  | Som(e1,e2) ->     print_string "("; stampaEspressione e1;  print_string " + "; stampaEspressione e2; print_string ")";
  | Diff(e1,e2) ->    print_string "("; stampaEspressione e1;  print_string " - "; stampaEspressione e2; print_string ")";
  | Molt (e1,e2) ->   print_string "("; stampaEspressione e1;  print_string " * "; stampaEspressione e2; print_string ")";
  | Div (e1,e2) ->    print_string "("; stampaEspressione e1;  print_string " / "; stampaEspressione e2; print_string ")";   
  | Power (e1,e2) ->  print_string "("; stampaEspressione e1;  print_string "^"; stampaEspressione e2; print_string ")";      
  | Seno e ->         print_string " sin(";  stampaEspressione e;   print_string ")"
  | Coseno e ->       print_string " cos(";  stampaEspressione e;   print_string ")"
  | Tangente e ->     print_string " tan(";  stampaEspressione e;   print_string ")"
  | Cotangente e ->   print_string " cot(";  stampaEspressione e;   print_string ")"
  | Secante e ->      print_string " sec(";  stampaEspressione e;   print_string ")"
  | Cosecante e ->    print_string " csc(";  stampaEspressione e;   print_string ")"
  | Logaritmo e ->    print_string " log(";  stampaEspressione e;   print_string ")"
  | _ -> print_string "null";;


(* 
   Riduce parzialmente il risultato finale 
*)
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
   | Secante(e1) -> Secante(ricombina e1)
   | Cosecante(e1) -> Cosecante(ricombina e1)
	| Costante c -> Costante c
	| Variabile x -> Variabile x
;;

let rec ricombinaFinoAeguaglianzaEspressioni exp aux =
  if (exp = aux) then exp
  else (ricombinaFinoAeguaglianzaEspressioni (ricombina exp) exp);;

let ricombinaFinoAeguaglianzaEspressioniWrapper exp =
  ricombinaFinoAeguaglianzaEspressioni (ricombina exp) exp;;

(* 
   funzione che richiama la funzione deriva e poi ricombina l'output restituito da quest'ultima 
*)
let derivaEricombina exp =
  ricombinaFinoAeguaglianzaEspressioniWrapper (deriva exp);;