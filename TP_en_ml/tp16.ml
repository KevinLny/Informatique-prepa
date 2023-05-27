(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 16 : Parcours de graphe en OCaml                         //
//  11/05/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*Exemple :*)

let ex_liste =
  [|
    [ 1; 4 ];
    [ 2; 3; 4 ];
    [ 1; 5 ];
    [ 1; 4; 6 ];
    [ 6 ];
    [ 7 ];
    [];
    [];
    [ 5; 9 ];
    [ 6; 8 ];
  |]

let ex_matrice =
  [|
    [| false; true; false; false; true; false; false; false; false; false |];
    [| false; false; true; true; true; false; false; false; false; false |];
    [| false; true; false; false; false; true; false; false; false; false |];
    [| false; true; false; false; true; false; true; false; false; false |];
    [| false; false; false; false; false; false; true; false; false; false |];
    [| false; false; false; false; false; false; false; true; false; false |];
    [| false; false; false; false; false; false; false; false; false; false |];
    [| false; false; false; false; false; false; false; false; false; false |];
    [| false; false; false; false; false; true; false; false; false; true |];
    [| false; false; false; false; false; false; true; false; true; false |];
  |]

(*Exercice 1 : Manipulation des graphes*)

let nb_sommmet_ma g =
  Array.length g

let nb_sommmet_lst g = 
  List.length g

let nb_arrete_ma g =
  let arrete = ref(0) in
  for i = 0 to nb_sommmet_ma g -1 do
    for j = 0 to Array.length g.(i) -1 do
      if g.(i).(j) then arrete := !arrete + 1
    done;
  done;
  !arrete

(*Exercice 2 : Bases des parcours*)

(*Question 1*)

let parcours_profondeur g x =
  let deja_visite = Array.make (Array.length g) false in
  let rec visiter y = 
    if not deja_visite.(y) then begin
      deja_visite.(y) <- true;
      print_int y;
      List.iter visiter g.(y)
    end
  in
  visiter x

(*Question 2*)

let ouvrir x = Printf.printf "Ouverture de %d\n" x;;

let fermer x = Printf.printf "Fermeture de %d\n" x;;


let parcours_profondeur_variant g x =
  let deja_visite = Array.make (Array.length g) false in
  let rec visiter y = 
    if not deja_visite.(y) then begin
      deja_visite.(y) <- true;
      ouvrir y;
      List.iter visiter g.(y);
      fermer y
    end
  in
  visiter x

(*Question 3*)

let parcours_prof g s =
  let est_visite = Array.make (Array.length g) false in
  let rec voisin x =
    if not est_visite.(x) then
      begin
        print_int(x);
        est_visite.(x) <- true;
          for y = 0 to Array.length g.(x) - 1 do
            if g.(x).(y) then
                voisin y;
          done;
      end
  in
  voisin s;;

let parcours_larg g x =
  let deja_enfile = Array.make (Array.length g) false in
  let file = Queue.create () in
  Queue.push x file;
  deja_enfile.(x) <- true;
  while not (Queue.is_empty file) do
    let s = Queue.pop file in
    print_int(s);
    for y = 0 to Array.length g.(s) -1 do
      if g.(s).(y) then begin
        if not deja_enfile.(y) then begin
          Queue.push y file;
          deja_enfile.(y) <- true;
        end
      end
    done;
  done;;

(*Question 4*)

let parcours_profondeur_variant_bis g x =
  let ouverture = Array.make (Array.length g) (-1) in
  let fermeture = Array.make (Array.length g) (-1) in
  let deja_visite = Array.make (Array.length g) false in
  let rec visiter y = 
    if not deja_visite.(y) then begin
      deja_visite.(y) <- true;
      ouverture.(y) <- y;
      List.iter visiter g.(y);
      fermeture.(y) <- y
    end
  in
  visiter x;
  ouverture,fermeture