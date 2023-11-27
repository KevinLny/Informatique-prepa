(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 5 : Automates finis                                      //
//  10/11/2023                                                  //
////////////////////////////////////////////////////////////////*)

(* Automates déterministe*)

exception Blocage

type afd = {
  nb_etats : int;
  finaux : bool array;
  transitions : (int * char * int) list;
};;

let l1 = {nb_etats = 1; finaux = [|true|]; transitions = [(0,'a',0)]};;
let l1bis = {nb_etats = 2; finaux = [|true;true|]; transitions = [(0,'a',0);(0,'b',1)]};;
let l2 = {nb_etats = 1; finaux = [|true|]; transitions = []};;
let l2 = {nb_etats = 1; finaux = [|false|]; transitions = []};;

(*Question 4*)

let execute la mot =
  let rec reconnaitre l lettre q =
    match l with
    |(x,y,z)::t when x = q -> if y = lettre then z else reconnaitre t lettre q
    | _ -> raise Blocage
  in
  let rec aux la mot q =
  match mot with
  | [] -> q
  | h::t -> aux la t (reconnaitre la.transitions h q )
  in
  aux la mot 0

(*Question 5*)

let reconnait afd mot = 
  try afd.finaux.(execute afd mot) with | Blocage -> false

(*Question 6*)

(* Automate complet émondé*)

(*Questino 7*)

let est_complet mot afd =
   