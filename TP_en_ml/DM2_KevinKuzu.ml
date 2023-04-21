(*
Kevin Kuzu
*)

(*************************EXERCICE 1***************************************)

type complexe = {
  mutable re : float; mutable im : float;
}

(*Question 1*)

let partie_relle nbr_complexe =
  nbr_complexe.re

let a = {re = 10.0; im = 5.0}

let _ = assert((partie_relle a) = 10.0)

let partie_imaginaire nbr_complexe =
  nbr_complexe.im

let _ = assert((partie_imaginaire a) = 5.0)

(*Qurstion 2*)

let conjugue nbr_complexe =
  nbr_complexe.im <- -. nbr_complexe.im

let _ = conjugue a
let _ = assert((partie_imaginaire a) = -5.0)
(*Question 3*)

let reinitialiser nbr_complexe =
  nbr_complexe.re <- 0.0;
  nbr_complexe.im <- 0.0

let _ = reinitialiser a
let _ = assert((partie_imaginaire a) = 0.0 && (partie_relle a) = 0.0)

(*Question 4*)

let norme nbr_complexe =
  sqrt(nbr_complexe.re**2. +. nbr_complexe.im**2.)

let c = {re = 4.0; im = 4.0}
let _ = assert((norme c) = sqrt(32.))

(*Question 5*)

let incremente nbr_complexe =
  nbr_complexe.re <- nbr_complexe.re +. 1.

let _ = incremente c
let _ = assert((partie_relle c) = 5.)

(*Question 6*)

let multiplier z1 z2 =
  let z1bis = z1.re in
  z1.re <- z1.re *. z2.re -. z1.im *. z2.im;
  z1.im <- z1bis *. z2.im +. z1.im *. z2.re

let z1 = {re = 4.0; im = 4.0}
let z2 = {re = 128.0; im = 65.0}

let _ = multiplier z1 z2
let _ = assert((partie_relle z1) = 252. && (partie_imaginaire z1) = 772.)

(*************************EXERCICE 2***************************************)

(*Question 1*)

let f x =
  print_int x;
  print_newline()

  (*Question 2*)

let g x y =
  print_string ("(");
  print_int x;
  print_string(", ");
  print_float y;
  print_string(")");
  print_newline()

(*Question 3*)

let affiche_liste_entier lst =
  List.iter f lst

(*************************EXERCICE 3***************************************)

(*Question 1*)

let affiche_ref_entier x =
  print_int(!x);
  print_newline()

let x = ref(1)

(*Question 2*)

let echange_references x1 x2 =
  let temp = !x1 in
  x1 := !x2;
  x2 := temp

let y = ref(10)

(*Question 3*)

let creer_ref n = 
  let r = ref n in 
  r := !r + 1;
  r;;

let n = 10
let n_bis = creer_ref n

(*Question 5*)

let incrementer x =
  x := !x +1

let a = ref(4)

(*Question 6*)
let incrementer_flottant x =
  x := !x +. 1.

let a_float = ref(4.)

(*Question 7*)
let modifie_premier_element couple x  =
  couple := x,snd !couple

let modifie_second_element couple x  =
  couple := fst !couple,x

(*************************EXERCICE 4***************************************)

(*Question 1*)

let somme_entiers n =
  let somme = ref(0) in
  for i = 0 to n do
    somme := !somme + i;
  done;
  !somme

let somme_entiers_rapide n =
  n *(n+1)/2

(*Question 2*)

let somme_entiers n =
  let somme = ref(0) in
  for i = 0 to n do
    somme := !somme + i;
    print_int(!somme);
    print_newline();
  done;
  !somme

(*Question 3*)

let euclide a b =
  while !b != 0 do
    a := !b;
    b := !a mod !b;
  done;
  !a

(*Question 4*)

let retourner_imperatif lst =
  let lstdonne,lstbis = ref(lst),ref([]) in
  while !lstdonne != [] do
    lstbis := (List.hd !lstdonne)::!lstbis;
    lstdonne := List.tl !lstdonne;
  done;
  !lstbis

(*On retourne la liste*)

(*************************EXERCICE 5***************************************)

(*Question 1*)
let element_zero lst =
  lst.(0)

let _ = assert((element_zero [|1;2;3;4;5|]) = 1)

(*Question 2*)

let nombre_occurence lst x =
  let n = ref(0) in
  for i = 0 to Array.length lst - 1 do
    if x = lst.(i) then n := !n + 1;
  done;
  !n

let _ = assert((nombre_occurence [|1;2;3;4;5;5;5;5;5|] 5) = 5)

(*Question 3*)

let somme_bornes lst i j =
  let somme = ref(0.) in
  for k = i to j - 1 do
    somme := !somme +. lst.(k)
  done;
  !somme

let _ = assert((somme_bornes [|1.;2.;3.;4.;5.;5.;5.;5.;5.|] 4 9) = 25.)

(*Question 4*)

let indice_min lst =
  if lst = [||] then print_string("Aucun min vu que tab vide");
  let indice_min = ref(0) in
  for i = 0 to Array.length lst -1 do
    if lst.(!indice_min) > lst.(i) then indice_min := i
  done;
  !indice_min

let _ = assert((indice_min [|1;2;3;4;5;6;0|]) = 6)
let _ = assert((indice_min [|1;2;3;0;4;5;6|]) = 3)

(*Question 5*)

let echange lst i j =
let temp = lst.(i) in
lst.(i) <- lst.(j);
lst.(j) <- temp;;

let lst_test = [|0;1|]

(*Question 6*)

let tri_selection lst = 
  for i = 0 to Array.length lst -1 do
    for k = i to Array.length lst -1 do
      if lst.(i)>lst.(k) then echange lst i k
      done;
    done;;

let lst_test1 = [|4;3;2;1|]

(*Question 7*)

let somme_cumulees tab =
  let somme = ref(0.) in
  for i = 0 to Array.length tab -1 do
    tab.(i) <- tab.(i) +. !somme;
    somme := !somme +. tab.(i);
  done;
  tab;;

let tab_test2 = [|0.; 1.; 2.; 3.|]
let _ = assert((somme_cumulees tab_test2) = [|0.; 1.; 3.; 7.|])

(*Question 8*)

let moyenne tab =
  let somme = ref(0.) in
  for i =0 to Array.length tab -1 do
    somme := !somme +. tab.(i);
  done;
  !somme /. float(Array.length tab)

(*Question 9*)
let array_to_list tab =
  let lstbis = ref([]) in
  for i = 0 to Array.length tab -1 do
  lstbis := tab.(Array.length tab -1 -i)::!lstbis;
  done;
  !lstbis;;

(*Question 10*)


let lst_test4 = [|0;1;2;3;4|]

(*Question 11*)