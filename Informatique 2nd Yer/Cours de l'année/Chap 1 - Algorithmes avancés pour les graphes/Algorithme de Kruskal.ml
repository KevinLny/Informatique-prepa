(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 2 : Algorithme de Kruskal                             //
//  28/09/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*/////////////////////////////////////////////////////////////////
 //                                                              //
 //                Algorithme de Kruskal                         //
 //                                                              //
 ////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - Algorithme de Kruskal :
    Données : G, poids

    E <- 0
    Initialiser une structure unir et trouver avec les sommets de G
    Trier A(G) par ordre croissant de poids
    Pour chaque arête (u,v) de A(G) pris dans l'ordre des poids croissants:
      Si trouver u != trouver v
      E <- E U {(u,v)}
      union (u,v)
    Renvoyer E

  - A tout instant, G[E] est acyclique

  - Kruskal renvoie un arbre couvrant de poids minimal

  - La compléxité de Kruskal est de O(|A|ln(S))
*)

type  unir_trouver = { parent : int array; rang : int array};;

let creation n = { parent = Array.init n (fun x -> x); rang = Array.make n 0}

let rec trouver u x =
  let y = u.parent.(x) 
  in
  if y = x then 
    x
  else begin
    let y_rep = trouver u y in
    u.parent.(x) <- y_rep;
    y_rep
  end

let rec unir u x y = 
  let x_repr = trouver u x in
  let y_repr = trouver u y in
  if u.rang.(x_repr) > u.rang.(y_repr) then
    u.parent.(y_repr) <- x_repr
  else begin
    u.parent.(x_repr) <- y_repr;
    if u.rang.(x_repr) = u.rang.(y_repr) then
      u.rang.(y_repr) <- u.rang.(y_repr) +1
  end

let nb_sommets = 5

let exemple_aretes = [(0, 1, -2); (0, 2, 5); (1, 2, 3); (1, 3, 8); (2, 3, 7); (2, 4, 9); (3, 4, 1)]

let kruskal n aretes =
  (*
    Arguments : (n : le nombre de sommets) (aretes : la liste des arêtes)
    Returns : la liste des arêtes	d'un arbre couvrant de poids minimal
  *)
  let ut = creation n in
  let comp_aretes (_, _, p1) (_, _, p2) =
    compare p1 p2 in
  let tri_aretes = List.sort comp_aretes aretes in
  let rec aux solution aretes = match aretes with
      | [] -> solution
      | (u, v, p) :: l -> 
        if trouver u <> trouver v then begin
          unir u v;                           (*Ne comprend pas l'erreur*)
          aux ((u, v, p):: solution) l
      end
      else aux solution l
  in
  aux [] tri_aretes