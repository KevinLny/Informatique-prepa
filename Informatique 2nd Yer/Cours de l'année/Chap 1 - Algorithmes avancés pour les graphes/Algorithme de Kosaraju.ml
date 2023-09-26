(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 1 : Algorithme de Kosaraju                            //
//  24/09/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - L'algorithme de parcours en profondeur se fait en O(|S| + |A|).

  - A tout instant de l'algorithme on a un sommet v de G qui est dans 1 de ces 3 états :
                ~ non visité s'il n'est pas visité par l'algorithme.
                ~ actif si explore a été appelé sur v mais n'a pas encore terminé.
                ~ traité si explore a terminé son execution sur v.

  - Il n'y a pas d'arc d'un sommet traité vers un sommet non visité. Car on parcours
    tout le temps les voisins de chaques sommets avant de les traités.

  - l'ensemble des sommets actifs est exactement l'ensemble des ancêtres du sommet en cours.

  - Deux sommet u et v sont fortement connectés s'il existe un chemin de u à v et de v à u.

  - Il existe toujours une composante pluie et source

  - Algorithme de Kosaraju :
                Données : G
                Faire un parcours en profondeur de G
                Pour chaque sommet de G pris dans l'ordre décroissant de fin de traitement:
                  Si v n'est pas marqué:
                    Marquer tous les sommets non marqués et accessibles depuis v dans G 
                    renversé par une nouvelle couleur.

  - Théorème de Kosaraju : Deux sommets ont la même couleur si et seulement si ils sont 
    de la même composante fortement connexe.

  - L'algorithme de Kosaraju est en O(|S| + |A|)

  - Le problème 2-SAT (deux-satisfiabilité) est un problème de décision en théorie de la 
    complexité computationnelle. Il s'agit d'un cas particulier du problème SAT (satisfiabilité 
    booléenne), qui consiste à déterminer si une expression booléenne peut être satisfaite par
    une assignation de valeurs de vérité (Vrai ou Faux) aux variables.

  - Il existe un algorithme linéaire en O(|S| + |A|) pour résoudre 2-SAT

              
*)

let exemple = [|[1; 2; 7]; [3;4]; [1;5;6]; [0]; []; []; []; [6;8]; []; [7]|];;

let exemple_kosarajou = [|[2]; [0; 4]; [1; 5]; [5]; []; [4; 6]; [8]; [6]; [7]|];;

(*
 g est un graphe
 s est le sommet qu'on parcourt
 temps est le nombre de sommet qu'on a traité 
 vu est un tableau de sommet visité
 parent est le tableau des parents de chaque sommet
 fin est le tableau indiquant la fin de traitement de chaque sommet  
*)

let rec explore g s temp vu parent fin =
  let parcours_voisins v =
    if not vu.(v) then begin
      vu.(v) <- true;
      explore g v temp vu parent fin end
  in
  List.iter parcours_voisins g.(s);
  fin.(s) <- !temp;
  temp := !temp +1;;

let parcours_profondeur g =
  let temps = ref(0) in
  let n = Array.length g in
  let vu = Array.make n false in
  let parent = Array.make n (-1) in
  let fin_traitement = Array.make n (-1) in
  for s = 0 to n-1 do
    if not vu.(s) then
      explore g s temps vu parent fin_traitement;
  done;
  fin_traitement,parent;;

(* ----------------------------------------------------------------*)

let rec explore2 g s vu pile =
  vu.(s) <- true;
  let parcours_voisins v =
    if not vu.(v) then
      explore2 g v vu pile;
  in
  List.iter parcours_voisins g.(s);;

let rec sommets_accessibles g s vu couleur composantes = 
  vu.(s) <- true;
  let parcours_voisins v =
    if not vu.(v) then
      sommets_accessibles g v vu couleur composantes;
  in
  List.iter parcours_voisins g.(s);;

let renverse g =
  (*On renvoie le graphe de g avec les arêtes de g sont retournées*)
  let n = Array.length g in
  let rev_g = Array.make n [] in
  let parcours_voisins s v =
    rev_g.(v) <- v::rev_g.(s)
  in
  for s = 0 to n-1 do
    List.iter (parcours_voisins s) g.(s)
  done;
  rev_g

let kosaraju g =
  let n = Array.length g in
  let vu = Array.make n false in
  let pile = Stack.create () in 
  for s = 0 to n - 1 do
    if not vu.(s) then 
      explore2 g s vu pile
  done;
  let vu2 = Array.make n false in 
  let composantes = Array.make n (-1) in
  let c = ref(0) in 
  let rev_g = renverse g in 
  while not (Stack.is_empty pile) do
    let s = Stack.pop pile in
    if not vu2.(s) then begin
      sommets_accessibles (rev_g) s vu2 !c composantes;
      c := !c + 1
    end
  done;
  composantes