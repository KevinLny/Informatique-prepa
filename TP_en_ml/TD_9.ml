type 'a abr =
| V
| N of 'a abr * 'a * 'a abr

(*Q1*)

let arbre_1 = N(N(N(N(V,-6.,V),-5.1,N(V,-4.8,V)),1.2,N(V,3.1,V)),3.5,N(N(V,3.8,V),5.1,N(V,10.5,V)))

(*Q2*)

let rec min_abr abr =
  match abr with
  |V -> failwith"Vide"
  |N(V,e,V) -> e
  |N(g,e,d) -> min_abr g


let rec max_abr abr =
  match abr with
  |V -> failwith"Vide"
  |N(V,e,V) -> e
  |N(g,e,d) -> max_abr d

(*Q3*)

let rec est_abr abr =
  match abr with
  | V -> true
  | N(V,e,V) -> true
  | N(V,e,d) -> e < min_abr d && est_abr d
  | N(g,e,V) -> e > max_abr g && est_abr g
  | N(g,e,d) -> e > max_abr g && e < min_abr d && est_abr g && est_abr d

(*Q4
   test a avec (-6.) sinon il croit c'est un entier*)

let rec recherche abr valeur =
  match abr with
  | V -> false
  | N(g,e,d) -> e = valeur || if e > valeur then recherche g valeur 
                              else recherche d valeur

(*Q5*)

(*Q6*)

let rec insere abr valeur =
    match abr with
    |V -> N(V,valeur,V)
    |N(g,e,d) -> if e = valeur then abr else if e > valeur then N(insere g valeur,e,d) else N(g,e,insere d valeur)

let arbre_2 = insere arbre_1 40.;;

(*Q8*)

let rec abr_of_list lst =
  match List.rev lst with
  | [] -> V
  | h::t -> insere (abr_of_list t) h

(*Q9*)

let rec parcour_infixe abr =
  match abr with
  | V -> []
  | N(g,e,d) -> parcour_infixe g @ (e :: parcour_infixe d)

let tri lst =
  parcour_infixe (abr_of_list lst)

(*Q10  La fonction supprime PS : J'ai pas regardé l'exo 2*)

(*Exercice 2*)

(*Q1*)
(*Q2*)

let rec supprime a x =
  let rec tout_gauche g d =
    match d with
    | V -> g
    | N(a1,e,a2) -> N(tout_gauche g a1, e, a2) in
  match a with
  | V -> failwith"Il n'y a rien a supprimer"
  | N (V, e, d) when e = x -> d
  | N (g, e, V) when e = x -> g
  | N (g, e, d) when e < x -> N(g,e,supprime d x)
  | N (g, e, d) when e > x -> N(supprime g x, e, d)
  | N (g, e, d) -> tout_gauche g d