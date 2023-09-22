(*Question 1*)

let double_premier lst =
  match lst with 
  | [] -> []
  | h::t -> (2*h)::t;;

let rec double_dernier lst = 
  match lst with
  |[] -> []
  |[x] -> [2*x]
  |h::t -> h:: double_dernier t
(*Question 2*)

let rec somme_liste l =
if l = [] then 0.
else (List.hd l) +. somme_liste (List.tl l);;

(*Question 3*)

let rec longueur lst = 
  match lst with
  | [] -> 0.
  | head::tail -> 1. +. longueur tail;;

(*Question 4*)

let moyenne_liste lst =
  if lst = [] then 0.
  else somme_liste(lst) /. longueur(lst);;

let moyenne_listev2 lst = 
  let rec moyenne_aux l_aux =
    match l_aux with
    |[] -> (0.,0)
    |t::q -> let (s,n) = moyenne_aux q in (s+.t, n+1)
  in
  let (total, taille) = moyenne_aux l in 
  total/. float_of_int taille

(*Question 5*)

(*let rec concatener l1 l2 =
  match l1 with
  | [] -> l2
  | head::tail -> head::(tail concatener l2);;*)

(*Question 6*)
(*Question 7*)
let rec mirroir lst =
  match lst with
  | [] -> []
  | head::tail -> (mirroir tail)@[head];;


(*Question 8*)

(*Question 9*)

let rec mirroir_efficace lst =
  let rec mirroir_aux l_aux acc=
    match l_aux with
    |[] -> acc
    |h::q -> mirroir_aux t (h::acc)
  in mirroir_aux l []