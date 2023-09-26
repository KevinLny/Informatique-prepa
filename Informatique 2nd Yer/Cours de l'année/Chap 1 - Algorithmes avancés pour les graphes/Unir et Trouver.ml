(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 2 : Unir et Trouver                                   //
//  26/09/2023                                                  //
////////////////////////////////////////////////////////////////*)


(* 
Notion importante à connaitre :

  - Un arbre couvrant d'un graphe connexe G = (S,A) est un ensemble de |S| - 1 
  arêtes sans cycle. Il couvre tout les sommets.
  
  - Une stucture unir et trouver (Union-Find) est une structure de données qui 
  dispose de deux operations:
      -> trouver (x) : renvoie un représentant de la classe d'équivalence de x.
        qui est unique pour chaque classe.
      -> unir(x,y) : unit dan sla structure les classes de x et y.

  - Version avec dictionnaire :
      -> le représentant de chaque éléments est donné par un dictionnaire.
      -> trouver en O(1) unir en O(n) avec n éléments?

  - Version avec arbre :
      -> La représentant de la classe d'une éléments est la racine de l'arbre?
  
  - 1ere heuristique : l'union par rang
      -> Lorsque l'on fusionne on fait pointer l'arbre de plus petit rang
        sur celui de plus grand rang.
      -> Si x a rang k alors le ss-arbre qu'il engendre a une taille d'au moins 2^k.
      -> Le rang d'un sommet est la profondeur du ss-arbre qu'il engendre.
      -> Les opérations unir et trouver sont en O(log(n))

  - 2ème heuristique : la compréssion de chemin
      -> la compléxité de m opérations Unir ou Trouver est O(ma(n)) ou a est une fonction
      -> presque constante a(n) = O(log(log(n)))
      
*)

(*/////////////////////////////////////////////////////////////////
 //                                                              //
 //               VERSION AVEC DICTIONNAIRE                      //
 //                                                              //
 ////////////////////////////////////////////////////////////////*)
let elements = ["Paris"; "Lyon"; "Nantes"; "Dijon"; "Lille"];;

let classe = Hashtbl.create (List.length elements);;

let aux x = Hashtbl.add classe x x in
  List.iter aux elements;;

let trouver x =
  (*renvoie un représentant de la classe d'équivalence x. Il est unique pour chaque classe.*)
  Hashtbl.find classe x;;

let unir x y =
  (*Unit dans la structure les classes de x et y.*)
  let rep_y = trouver y in
  let f a b = 
    if b = rep_y then
      Hashtbl.replace classe a (trouver x)
  in
  Hashtbl.iter f classe;;


(*/////////////////////////////////////////////////////////////////
 //                                                              //
 //               VERSION AVEC DES ABRES                         //
 //                                                              //
 ////////////////////////////////////////////////////////////////*)

type 'a unir_trouver = { parent : ('a,'a) Hashtbl.t ; rang : ('a,int) Hashtbl.t}

let creation elements =
  let rang = Hashtbl.create (List.length elements) in
  let parent = Hashtbl.create (List.length elements) in
  let init e = Hashtbl.add rang e 0;
  Hashtbl.add parent e e in
  List.iter init elements;
  { parent = parent; rang = rang };;

let rec trouver_naif u x = 
  let pere_x = Hashtbl.find u.parent x in
  if pere_x = x then
    x
  else trouver_naif u pere_x

let rec unir_naif u x y =
  let rep_x = trouver_naif x in
  let rep_y = trouver_naif y in
  if rep_x <> rep_y then
    Hashtbl.replace u.parent rep_y rep_x;;

let elements = ["Paris"; "Lyon"; "Nantes"; "Dijon"; "Lille"];;
let ut = creation elements

(*/////////////////////////////////////////////////////////////////
 //                                                              //
 //               VERSION AVEC DES ABRES                         //
 //               ET LES 2 HEURISTIQUES                          //
 //                                                              //
 ////////////////////////////////////////////////////////////////*)

type 'a unir_trouver = { parent : ('a,'a) Hashtbl.t; rang : ('a,int) Hashtbl.t}

let creation elements =
  let rang = Hashtbl.create (List.length elements) in
  let parent = Hashtbl.create (List.length elements) in
  let init e = Hashtbl.add rang e 0;
  Hashtbl.add parent e e in
  List.iter init elements;
  { parent = parent; rang = rang }

let rec trouver u x =
  let y = Hashtbl.find u.parent x in 
  if y = x then
    x
  else begin
    let y_rep = trouver u y in
    Hashtbl.replace u.parent x y_rep;
    y_rep end
  
let rec unir u x y =
  let x_rep = trouver u x in
  let y_rep = trouver u y in
  if x_rep <> y_rep then begin
    let x_rang = Hashtbl.find u.rang x_rep in
    let y_rang = Hashtbl.find u.rang y_rep in
    if x_rang > y_rang then 
      Hashtbl.replace u.parent y_rep x_rep
    else begin
      Hashtbl.replace u.parent x_rep y_rep;
      if x_rang = y_rang then
        Hashtbl.replace u.rang y_rep (y_rang + 1)
    end
  end

let elements = ["Paris"; "Lyon"; "Nantes"; "Dijon"; "Lille"];;
let ut = creation elements