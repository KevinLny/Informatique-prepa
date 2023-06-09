
(*Plus besoin avec open de faire Fileprio.fun*)
open Fileprio
open Generer_graphe

(** l'appel [time f x] évalue [f x], imprime son temps d'exécution et renvoie sa
    valeur *)
let time f x =
  let t = Sys.time () in
  let fx = f x in
  Printf.printf "Execution time: %fs\n" (Sys.time () -. t);
  fx

(* tests du module Fileprio *)

let run_tests () =
  let pq = Fileprio.create () in
  assert (Fileprio.is_empty pq);
  Fileprio.add pq 1 3.0;
  Fileprio.add pq 2 1.5;
  Fileprio.add pq 3 2.2;
  let elem1, _ = Fileprio.pop pq in
  let elem2, _ = Fileprio.pop pq in
  let elem3, _ = Fileprio.pop pq in
  assert (2 = elem1);
  assert (3 = elem2);
  assert (1 = elem3);
  assert (Fileprio.is_empty pq);
  Fileprio.add pq 1 3.0;
  Fileprio.add pq 2 1.5;
  Fileprio.decrease pq 1 0.5;
  let elem4, _ = Fileprio.pop pq in
  let elem5, _ = Fileprio.pop pq in
  assert (1 = elem4);
  assert (2 = elem5);
  assert (Fileprio.is_empty pq)

let _ = run_tests ()

let exemple_graphe_cours =
  [|
    [ (1, 10.); (2, 5.) ];
    [ (3, 1.); (2, 2.) ];
    [ (1, 3.); (3, 9.); (4, 2.) ];
    [ (4, 4.) ];
    [ (3, 6.); (0, 7.) ];
  |]

(* génération du gros graphe de travail *)

let exemple_graphe_NY = Generer_graphe.graph_from_filename "USA-road-d.NY.gr"
(* ce graphe correspond au réseau routier de New York. Il contient le réseau
   routier de New York, avec 264_346 noeuds et 733_846 arcs. Attention : les
   sommets sont étiquetés dans le fichier "USA- ... .gr" de 1 à 264_346, j'ai
   décrémenté tous les numéros de sommets de 1 pour éviter que ce sommet soit
   isolé dans le graphe. Ce graphe est connexe, et même si on ne va pas
   l'utiliser on le considère comme non orienté. *)

(* la taille de ce graphe est suffisamment raisonnable pour que djikstra avec
   les files de priorité naïves se fasse en un temps raisonnable (< 10s, sans
   doute plutôt 1-2s mais j'ai un doute sur la puissance des PCs du lycée). Vous
   pouvez regarder les graphes plus gros dans le lien dans le TP, cette
   implémentation naïve montrera rapidement ses limites. *)

(*~~~~~~~~Exercice 2 – Implémentation de l’algorithme de Dijkstra~~~~~~~~*)

(*Question 1*)
let dijkstra graph s =
  let n = Array.length graph in
  let a_visiter = create() in
  let dist = Array.make n infinity
  in
  dist.(s) <- 0.;
  add a_visiter s 0.;
  while not (is_empty a_visiter) do
    let x,dx = pop a_visiter 
    in
    List.iter (fun (y,p) ->
      let d = dx +. p in
      if d < dist.(y) then
        begin
          if dist.(y) < infinity then decrease a_visiter y d
          else add a_visiter y d;
        dist.(y) <- d
        end) graph.(x)
  done;
  dist

(*Question 2
  complexité spatiale = |S| Complexité temporelle = O(n² + np)
*)

(*Question 3*)

let dijkstra_point_a_point graph s1 s2 =
  let n = Array.length graph in
  let temp = ref true in
  let a_visiter = create() in
  let dist = Array.make n infinity
  in
  dist.(s1) <- 0.;
  add a_visiter s1 0.;
  while !temp do
    let x,dx = pop a_visiter
    in
    if x = s2 then temp := false else
    List.iter (fun (y,p) ->
      let d = dx +. p in
      if d < dist.(y) then
        begin
          if dist.(y) < infinity then decrease a_visiter y d
          else add a_visiter y d;
        dist.(y) <- d
        end) graph.(x)
  done;
  dist.(s2)