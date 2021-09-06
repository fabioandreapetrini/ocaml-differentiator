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

  type listaExpr =
ListaExpr of (expr list);;


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
  

let rec stampaEspressione = function
| Costante x -> print_string "Costante(";     print_float x;      print_string "0)"
| Variabile x -> print_string "Variabile(";   print_string x;     print_string ")"
| Som(e1,e2) -> print_string " Som(";         stampaEspressione e1;         print_string ", ";        stampaEspressione e2;          print_string ")"
| Diff(e1,e2) -> print_string " Diff(";       stampaEspressione e1;         print_string ", ";        stampaEspressione e2;          print_string ")"
| Molt (e1,e2) -> print_string " Molt(";      stampaEspressione e1;         print_string ", ";        stampaEspressione e2;          print_string ")"
| Div (e1,e2) -> print_string " Div(";        stampaEspressione e1;         print_string ", ";        stampaEspressione e2;          print_string ")"
| Power (e1,e2) -> print_string " Power(";    stampaEspressione e1;         print_string ", ";        stampaEspressione e2;          print_string ")"
| Seno e -> print_string " Seno(";            stampaEspressione e;          print_string ")"
| Coseno e -> print_string " Coseno(";        stampaEspressione e;          print_string ")"
| Tangente e -> print_string " Tangente(";            stampaEspressione e;          print_string ")"
| Cotangente e -> print_string " Cotangente(";            stampaEspressione e;          print_string ")"
| Logaritmo e -> print_string " Logaritmo(";            stampaEspressione e;          print_string ")"
| _ -> print_string "null";;


