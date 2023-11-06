(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 5 : Algorithme Minmax pour les Puissance 4.              //
//  13/10/2023                                                  //
////////////////////////////////////////////////////////////////*)

let est_gagnant e c =
  let b = ref false in
  let aligne = ref true
  in
  for i = 0 to nb_lignes - 1 do
    for j = 0 to nb_colonnes - 1 do 
      for direction = 0 to 3 do
        for k = 0 to 3 do  
          let new_c = move_case k (i,j) direction in
          aligne := !aligne && is_in new_c && is_color etat.game new.c c
        done;
        b := !b || !aligne
      done;
    done;
  done;
  !b

(*1. Définition d'une heuristique*)

(*Question 1*)

let heuristique state color =
  if est_gagnant state color then max_int else
  if est_gagnant state (autre color) then min_int else
  let sum = ref 0 
  in
  for i = 0 to nb_lignes -1 do
    for j = 0 to nb_colonnes -1 do
      if state.game.(i).(j) = Some color then sum := !sum + val_cases.(i).(j);
      if state.game.(i).(j) <> None then sum := !sum - val_cases.(i).(j);
    done;
  done;
  !sum

(*Graphe d'états*)

(*Question 2*)

let place_jeton (e: etat) (j: int): etat option =
  let res = ref None
  in
  for i = 0 to nb_lignes -1 do
    if e.game.(i).(j) = None && !res = None then begin e.game.(i).(j) <- Some e.joueur; res := Some e end
  done;
  !res

let next state =
  