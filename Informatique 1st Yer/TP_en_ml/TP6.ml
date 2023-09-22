(*Exercice 3*)
type 'a pile = 'a list

let creer_pile =
  []

let est_vide pile =
  pile = []

let push pile x =
  x::pile

let pop pile =
    match pile with
    |[] -> failwith"Pile vide"
    |h::t -> h,t


(*Exercice 5*)

type 'a queue_fonc = 'a pile * 'a pile
let empty_queue = ([],[])

let is_empty file =
  file = ([],[])

let push file x =
  x::fst(file),snd(file)

let list_to_file liste =
  ([]),liste

let egale q r =
  let qg , qd = q in
  let rg , rd = r in
  qg @ List.rev qd = rg @ List.rev rd

let rec pop file = 
  if snd(file) != [] then 
    match snd(file) with
    |[] -> failwith"Pile vide"
    |h::t -> h, ([],t)
  else pop([], List.rev(fst(file)));;

(*Question 4 : 
  -Complexité de push est en O(1) car il fait une copie seulement.
  -Complexité de pop est de O(1) car il fait une copie si lg est vide seulment tel que ld = lg 
ainsi on a soit 1 ou 2 operations. Ce qui signifie qu'on a la fonction pop en O(1)
*)

(*Question 5 :
  -On en deduit par une somme de 1 à n qui represante le nombre d'appel des fonctions et 
ce que nous donne une complexité en O(n) elle est linéaire.
*)

(*Question 6*)

let rec somme file =
  match fst(file), snd(file) with
  |[],[] -> 0
  |[], h::t -> h + somme ([],t)
  |h::t,[] -> h + somme ([],t)
  |h1::t1,h2::t2 -> (h1 + h2) + somme (t1,t2)

let rec affiche_file file =
  let l = fst(file) in
  match l with
  |[] -> if snd(file) != [] then affiche_file ((List.rev (snd(file))), [])
  |h::t ->
    print_int(h);
    print_newline();
    affiche_file(t,snd(file));;

let file_to_list file =
  fst(file)::(List.rev( snd(file)))

let liste_to_file list =
  ([],list)

(*Exercice 6*)

type 'a vector = {
  mutable data : 'a array;
  mutable lenght : int;
  default : 'a
}

(*let creer_vector =*)

let vec_est_vide vector = 
  vector.lenght = 0

let vec_est_egale v1 v2 =
  let final = ref(true) in
  if v1.lenght = v2.lenght then
    for i = 0 to v1.lenght do
      if v1.data.(i) != v2.data.(i) then final := false
      done;
  if v1.lenght != v2.lenght then final := false;
  !final

let resize vector n =
  vector.lenght <- n + vector.lenght
  v