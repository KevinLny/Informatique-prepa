(*************************EXERCICE 1***************************************)
(*Question 1*)

(*1*)
let rec puissance x n =
  if n = 0 then 1
  else x * puissance x (n-1)

(*2*)
(*Si n vaut 0 alors 0 sinon n^k + puissance n-1 k*)
let rec somme_n_puissance_k n k =
  if n = 0 then 0
  else puissance n k + somme_n_puissance_k (n-1) k

(*3*)
let binom k n =
  let rec factorielle n =       (*On introduit la définition de factorielle pour appliquer la formule du binome*)
    if n = 0 then 1
    else n * factorielle (n-1)
  in
  if k>=0 && k<=n then factorielle n / (factorielle k * factorielle (n-k) )
  else 0

(*4*)
let rec somme_list lst =
  match lst with
  | [] -> 0.
  |h::t -> h +. somme_list t

(*5*)
let rec croissant lst =
  match lst with
  | [] -> true
  | [h] -> true
  | h::h2::t -> if h <= h2 then croissant (h2::t) else false

(*6*)
let compare_tailles lst_1 lst_2 =
  let rec taille lst =            (*On introduit la fonction taille qui renvoie la taille d'une liste*)
    match lst with              
    | [] -> 0
    | _::t -> 1 + taille t
  in
  if taille lst_1 <= taille lst_2 then if taille lst_1 < taille lst_2 then 1 else 0
  else -1

(*************************EXERCICE 2***************************************)
(*Question 1*)
let rec insere lst x =
  match lst with
  | [] -> [x]
  | h::t -> if x <= h then x::h::t else h::insere t x

(*Question 2*)
let rec tri_insertion lst =
  match lst with
  | [] -> []
  | h::t -> insere (tri_insertion t) h

(*************************EXERCICE 3***************************************)

(*Question 1*)

let rec divise lst =
  match lst with
  |[] -> [],[]
  |h::[] -> lst,[]
  |h::h2::c -> let (l1, l2) = divise c in h::l1, h2::l2

(*Question 2*)
let rec fusionne lst1 lst2 =
  match lst1,lst2 with
  | [],_ -> lst2
  | _,[] -> lst1
  |h1::t1 , h2::t2 -> if h1<h2 then h1::fusionne t1 lst2 else h2::fusionne lst1 t2

(*Question 3*)
let rec tri_fusion lst =
  match lst with
  |[] -> []
  |h::[] -> lst
  |h::a -> fusionne (tri_fusion (fst (divise lst))) (tri_fusion (snd (divise lst)))

let _ = assert((puissance 2 4) = 16)
let _ = assert((somme_n_puissance_k 2 4) = 17)
let _ = assert((binom 2 2) = 1)
let _ = assert(somme_list([1.;2.;3.;4.]) = 10.)
let _ = assert(croissant([1;2;3;4;5]) = true)
let _ = assert(compare_tailles [1;2;3] [1;2;3] = 0)
let _ = assert(insere [1;3;4] 2 = [1;2;3;4])
let _ = assert(tri_insertion [1;5;2;8;3;1;2] = [1;1;2;2;3;5;8])
let _ = assert(divise [1;2;3;4;5] = ([1;3;5], [2;4]))
let _ = assert(fusionne [1;3;5] [2;4] = [1;2;3;4;5])
let _ = assert(tri_fusion [1;5;2;8;3;1;2] = [1;1;2;2;3;5;8])