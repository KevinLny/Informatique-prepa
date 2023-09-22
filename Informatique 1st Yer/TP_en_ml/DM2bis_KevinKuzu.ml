(*
Kevin Kuzu
*)

(*************************EXERCICE 1***************************************)

type trie =
 | V
 | N of char * trie * trie

let d_arbre = N('d',N('e',N('$',V,V),N('o',N('$',V,V),V)),N('s',N('a',N('c',N('$',V,V),V),N('i',N('$',V,N('r',N('e',N('$',V,V),V),V)),N('k',N('i',N('$',V,V),V),V))),V))

(*Q1 : site*)

(*Q2*)

let rec est_bien_forme tree =
  match tree with
  | V -> true
  | N(e,V,V) -> e = '$'
  | N(e,g,d) -> if e = '$' then g = V && est_bien_forme d 
                else g <> V && est_bien_forme g && est_bien_forme d

(*Q3 :
 Chaque chemin entre une racine
et une feuille représente un mot de l’ensemble, en enlevant le dernier caractère $.

Soit 𝜙 , l'ensemble des mots d'un trie A est définie inductivement par les relations :
 - 𝜙(∅) = {ε}
 - Si A = ('$',∅,∅) alors par défnition 𝜙(A) = ε
 - Si A = ('$',∅,Fd) alors 𝜙(A) = 𝜙(Fd)
 - Si A = (e, Fg,Fd) alors 𝜙(A) = 
                -si e = ‘$’ alors 𝜙(B) = {ε} U {𝜙(s2)}
	              -si e ≠ ‘$’ alors 𝜙(B) = (c . 𝜙(s1)) . 𝜙(s2)
*)

(*Q4*)

type mot = char list 

let mot_of_string chaine =
  let mot,n = ref(['$']),String.length chaine in
  for i = 0 to n -1 do
    mot := chaine.[n - i - 1]::!mot
  done;
  !mot

(*Q5*)

let rec afficher_mot mot =
  match mot with
  | [] -> print_char ' '
  | h::t -> if h <> '$' then print_char h; afficher_mot t

(*************************EXERCICE 2***************************************)

(*Q1*)

let rec cardinal tree =
  match tree with
  | V -> 0
  | N(e,g,d) -> if e = '$' then 1 + cardinal g + cardinal d else cardinal g + cardinal d

(*Q2*)

let rec recherche tree mot =
  match tree,mot with
  | V , [] -> failwith"Arbre vide ou aucun mot"
  | _ , [] -> false
  | V, _ -> false 
  | N(e,V,V) , h::t -> e = '$' && h = '$'
  | N(e,g,d) , ['$'] -> e = '$'
  | N(e,g,d) , h::t -> if e = h then recherche g t  else recherche d mot

let _ = assert( recherche d_arbre ['s';'i';'r';'e';'$'] = true)
let _ = assert( recherche d_arbre ['f';'a';'l';'s';'e';'$'] = false)

(*Q3*)

let rec insere trie mot =
  match trie,mot with
  | V , [] -> trie
  | V , h::t -> (N(h,insere V t,V))
  | N(_), [] -> trie
  | N(e,g,d), h::t -> if e = h then N(e,insere g t,d) else N(e,g,insere d mot)

let test = insere V ['B';'O';'N';'$'];;
let testbis = insere test ['H';'E';'L';'L';'$'];;
let d_arbre = insere d_arbre ['L';'O';'L';'$'];;

let _ = assert(recherche test ['B';'O';'N';'$'] = true)
let _ = assert(recherche testbis ['B';'O';'N';'$'] = true)
let _ = assert(recherche testbis ['H';'E';'L';'L';'$'] = true)
let _ = assert(recherche d_arbre ['L';'O';'L';'$'] = true)

(*Q4*)

let rec trie_of_list chaine =
  match chaine with
  |[] -> V
  |h::t -> insere (trie_of_list t ) (mot_of_string h)

let trie_n = trie_of_list ["sire"; "site"; "ski"; "sac"; "dodos"; "dodu"; "dole"; "de"; "si"; "do"]

(*Même arbre que l'exemple donnée sur l'énoncé*)

(*Q5*)

let rec longueur_max trie =
  match trie with
  | V -> -1
  | N('$',V,V) -> 0
  | N('$',_,d) -> longueur_max d
  | N(e,g,d) -> max (1 + longueur_max g) (longueur_max d)

let _ = assert(longueur_max trie_n = 5)

(*Q6*)

let rec compte_mots_longs t n =
  match t with  
  |V -> 0 
  |N(v,g,d) -> 
    if v='$' then
      if n<1 then 
        1 + compte_mots_longs d n
      else
        compte_mots_longs d n
    else  
      compte_mots_longs g (n-1) + compte_mots_longs d n

let _ = assert(compte_mots_longs trie_n 5 = 5)

(*Q7*)

let iter_trie f t = 
  let rec iter_trie_aux f t m =
    match t with 
    |V -> ()
    |N(v,g,d) -> 
      if v='$' then
        begin iter_trie_aux f g (m@[v]) ; iter_trie_aux f d m ; f m end
      else
        begin iter_trie_aux f g (m@[v]) ; iter_trie_aux f d m end
    in iter_trie_aux f t []

(*Q8*)

let rec f = function 
|[] -> print_endline " "  
|h::t -> print_char h ; f t

let affiche_mots t = iter_trie f t

let list_of_trie t = 
  let rec make_list t m =
    match t with 
    |V -> []
    |N(r,g,d) -> 
      if r ='$' then
        [m @ [r]] @ make_list d m 
      else
        make_list g (m @ [r]) @ make_list d m 
    in make_list t []

let _ = assert(list_of_trie trie_n = [['d'; 'o'; '$']; ['d'; 'o'; 'l'; 'e'; '$']; ['d'; 'o'; 'd'; 'u'; '$'];['d'; 'o'; 'd'; 'o'; 's'; '$']; ['d'; 'e'; '$']; ['s'; 'i'; '$'];['s'; 'i'; 't'; 'e'; '$']; ['s'; 'i'; 'r'; 'e'; '$']; ['s'; 'a'; 'c'; '$'];['s'; 'k'; 'i'; '$']])

(*Q9*)

let tableau_occurence mot =
  let tab ,motbis= Array.make 26 0, mot_of_string mot in
  for i = 0 to List.length motbis - 2 do
    tab.(int_of_char (List.nth motbis i) - 97) <- tab.(int_of_char (List.nth motbis i) - 97) +1
  done;
  tab

let _ = assert(tableau_occurence "azerty" = [|1; 0; 0; 0; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0; 1; 0; 1; 0; 0; 0; 0; 1; 1|])

(*************************EXERCICE 3***************************************)

(*Q1*)

let cat_first_line doc =
  let mots = open_in doc in
  let ligne = input_line mots in
try
Printf . printf "%s\n" ligne
with End_of_file -> close_in mots;;

(*Q2*)

let rec cat_first_100_lines doc =
  let mots = open_in doc in
try
  for i = 0 to 99 do
  Printf . printf "%s\n" (input_line mots)
  done;
with End_of_file -> close_in mots;
print_string "Fichier terminé !"

(*Q3*)

let rec cat doc =
  let mots = open_in doc in
try
  while true do
  Printf . printf "%s\n" (input_line mots)
  done;
with End_of_file -> close_in mots;;

(*Q4*)

let trie_of_file doc =
  let mots = open_in doc in
  let lst = ref([]) in
  try
    while true do
    lst := (input_line mots)::!lst
    done;
    trie_of_list !lst
  with End_of_file -> close_in mots;
  trie_of_list !lst;;

let trie_of_filebis doc =   (*Deux version car mon pc pense qu'il y a une boucle sans condition d'arrêt*)
  let mots = open_in doc in
  let t = ref(V) in
  try
    while true do
    t := insere !t (mot_of_string (input_line mots))
    done;
    !t
  with End_of_file -> close_in mots;
  !t;;

(*************************EXERCICE 4***************************************)

let trie_cinqcentmots = trie_of_filebis "cinq_cent_mots.txt"
let trie_scrable = trie_of_filebis "Scrable.txt" (* Des \r apparaît \o/ *)

let tableau_occurencebis mot = 
  let l = (List.length mot)-1 and tab = (Array.make 26 0)  in 
  for i = 0 to l-1 do 
    let j = int_of_char (List.nth mot i) - 97 in 
    tab.(j) <- tab.(j)+1
  done;
  tab 

(*Q1*)

(*vérifie que le nombre d'occurence de chaque lettre soient inférieur par rapport au mot d'oriine*)
let comparaison_sous_mots th tm =
  let b = ref true in 
  for i = 0 to 25 do 
    if th.(i) > tm.(i) then b := false
  done;
  !b
  
let sous_mots tr str =
  let liste = list_of_trie tr and m = mot_of_string str in
  let rec affiche lst mt =
    match lst with
    |[] | ['\r']::[] -> print_newline()
    |h::t -> 
      if (comparaison_sous_mots (tableau_occurencebis h) (tableau_occurencebis mt)) then 
        begin afficher_mot h ; affiche t mt end 
      else affiche t mt
    in affiche liste m

(*Q2*)
(*vérifie que le nombre d'occurence de chaque lettre soient égaux à ceux du mot d'oriine*)
let egalite th tm = 
  let b = ref true in 
  for i = 0 to 25 do 
    if th.(i) <> tm.(i) then b := false
  done;
  !b

let anagramme tr str =
  let liste = list_of_trie tr and m = mot_of_string str in
  let rec affiche lst mt =
    match lst with
    |[] | ['\r']::[] -> print_newline()
    |h::t -> 
      if (egalite (tableau_occurencebis h) (tableau_occurencebis mt)) then 
        begin afficher_mot h ; affiche t mt end 
      else affiche t mt
    in affiche liste m

(*Q3*)
let filtre_sous_mots tr str =
  let liste = list_of_trie tr and m = mot_of_string str in
  let rec gen_trie tr lst mt =
    match lst with
    |[] | ['\r']::[] -> tr
    |h::t -> 
      if (comparaison_sous_mots (tableau_occurencebis h) (tableau_occurencebis mt)) then 
        begin gen_trie (insere tr h) t mt end 
      else gen_trie tr t mt
    in gen_trie V liste m

let filtre_anagramme tr str =
  let liste = list_of_trie tr and m = mot_of_string str in
  let rec gen_trie tr lst mt =
    match lst with
    |[] | ['\r']::[] -> tr
    |h::t -> 
      if (egalite (tableau_occurencebis h) (tableau_occurencebis mt)) then 
        begin gen_trie (insere tr h) t mt end 
      else gen_trie tr t mt
    in gen_trie V liste m

(*Q4*)
let comparaison_sur_mots th tm = 
  let b = ref true in 
  for i = 0 to 25 do 
    if th.(i) < tm.(i) then b := false
  done;
  !b

let filtre_sur_mots tr str =
  let liste = list_of_trie tr and m = mot_of_string str in
  let rec gen_trie tr lst mt =
    match lst with
    |[] | ['\r']::[] -> tr
    |h::t -> 
if (comparaison_sur_mots (tableau_occurencebis h) (tableau_occurencebis mt)) then 
        begin gen_trie (insere tr h) t mt end 
      else gen_trie tr t mt
    in gen_trie V liste m

