(* les couleurs des jetons                                 *)
type couleur = Rouge | Jaune

(* les dimensions du plateau de jeu                        *)
let nb_colonnes = 7
let nb_lignes   = 6

(* le plateau des jeux, de dimension nb_lignes * nb_colonnes *)
type game = couleur option array array

(* un état du jeu                                          *)
type etat = { game : game ; joueur : couleur }

let autre = function Rouge -> Jaune | Jaune -> Rouge

(* Quelques fonctions graphiques *)
(* let color_of_couleur = function Rouge -> "O" | _ -> "X" *)
let red = "\027[31m" ;;
let yellow = "\027[93m" ;;
let neutre = "\027[m" ;;
let color_of_couleur = function Rouge -> red ^ "O" ^ neutre | _ -> yellow ^ "X" ^ neutre;; 

let draw_game (e: etat) =
  for i = nb_lignes -1  downto 0   do
    print_string("| ");
    for j = 0 to nb_colonnes-1   do
        match e.game.(i).(j) with
      | None -> print_string("  ");
      | Some c -> print_string(color_of_couleur c);print_string(" ");
    done;
    print_string("|\n");
  done;
  print_string("  ");
  for j = 0 to nb_colonnes-1   do
    print_int(j);print_string(" ")
  done;
  print_string("  \n");
;;

(* Boite à outils *)
(* d encode une direction : E, NE, N, NO, O, SO, S, SE
                            0   1  2   3, 4,  5, 6,  7
   on calcule la case obtenue en se déplaçant k fois dans la direction d, depuis la case (i, j)
*)
let rec move (k: int) (i, j) (d: int) =
  match d with
  | 0 -> (i+k, j)               (* E *)
  | 1 -> (i+k, j+k)             (* NE *)
  | 2 -> (i  , j+k)             (* N *)
  | 3 -> (i-k, j+k)             (* NO *)
  | _ -> move (-k) (i, j) (d-4)

(* permet de tester si une case (i, j) est dans le plateau de jeu *)
let is_in (i, j) =
  i >= 0 && j >= 0 && j < nb_colonnes && i < nb_lignes
(* permet de tester si une case (i, j) du plateau g est libre *)
let is_free g (i, j) =
  is_in (i, j) && g.(i).(j) = None
(* permet de tester si une case (i, j) du plateau g contient la couleur c *)
let is_color g (i, j) c =
  is_in (i, j) && g.(i).(j) = Some c

(* retourne une copie de la matrice mm *)
let copy_matrix mm =
  let n = Array.length mm in
  if n = 0 then [||]
  else
    let m = Array.length mm.(0) in
    if m = 0 then Array.init n (fun i -> [||])
    else
      Array.init n (fun i -> Array.copy mm.(i))

(* matrice des valeurs des cases *)
let val_cases =
  [|
    [|3 ; 4 ; 5  ; 7  ; 5  ; 4 ; 3|];
    [|4 ; 6 ; 8  ; 10 ; 8  ; 6 ; 4|];
    [|5 ; 8 ; 11 ; 13 ; 11 ; 8 ; 5|];
    [|5 ; 8 ; 11 ; 13 ; 11 ; 8 ; 5|];
    [|4 ; 6 ; 8  ; 10 ; 8  ; 6 ; 4|];
    [|3 ; 4 ; 5  ; 7  ; 5  ; 4 ; 3|];
  |]

(* fonctions à compléter, elles sont définies ici pour pouvoir faire typer le reste du programme *)


let est_gagnant e c =
  let b = ref false in
  let aligne = ref true
  in
  for i = 0 to nb_lignes - 1 do
    for j = 0 to nb_colonnes - 1 do 
      for direction = 0 to 3 do
        for k = 0 to 3 do  
          let new_c = move k (i,j) direction in
          aligne := !aligne && is_in new_c && is_color e.game new_c c
        done;
        b := !b || !aligne
      done;
    done;
  done;
  !b

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

let place_jeton (e: etat) (j: int): etat option =
  let res = ref None in
  let exprime = copy_matrix e.game
  in
  for i = 0 to nb_lignes -1 do
    if exprime.(i).(j) = None && !res = None then begin exprime.(i).(j) <- Some e.joueur; res := Some e end
  done;
  !res


let joue (e: etat) (d: int): etat =
  assert false



  
let etat_test = {game=Array.make_matrix nb_lignes nb_colonnes None; joueur = Rouge};;
etat_test.game.(0).(3) <- Some Rouge;
etat_test.game.(1).(3) <- Some Jaune;
etat_test.game.(0).(2) <- Some Rouge;
etat_test.game.(0).(0) <- Some Jaune;;
(* draw_game etat_test *)

(* attend que le joueur renvoie une colonne et retourne l'état du jeu après *)
let rec read_player_move (e: etat) =
  print_string("Dans quelle colonne voulez_vous jouez?\n");
  let i = read_int() in
  match place_jeton e i with
  | None -> read_player_move e
  | Some(g') -> g'


let main () =
  (* définition du jeu initial *)
  let init = { game = Array.make_matrix nb_lignes nb_colonnes None ; joueur = Rouge } in
  let rec play_with_user (e: etat) =
    draw_game e;
    (* le joueur joue *)
    let e' = read_player_move e in
    draw_game e';
    (* l'ordinateur joue *)
    let e'' = joue e' 5 in
    play_with_user e''
  in
  play_with_user init