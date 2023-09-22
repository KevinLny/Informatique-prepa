(*
type 'a tree =
|Leaf
|Node of 'a * 'a tree * 'a tree 

(* the code below constructs this tree:
         4
       /   \
      2     5
     / \   / \
    1   3 6   7
*)
let t =
  Node(4,
    Node(2,
      Node(1, Leaf, Leaf),
      Node(3, Leaf, Leaf)
    ),
    Node(5,
      Node(6, Leaf, Leaf),
      Node(7, Leaf, Leaf)
    )
  )

let etiquette_racine arbre =
  match arbre with
  | Leaf -> failwith"Empty"
  | Node (h, ag, ad) -> h

let rec contient_etiquette arbre etiquette =
  match arbre with
  |Leaf -> false
  |Node (h, ag, ad) -> if etiquette = h then true else 
    if contient_etiquette ag etiquette then true else contient_etiquette ad etiquette

let rec descendant_gauche arbre=
  match arbre with
  |Leaf -> failwith"Il n'y a plus rien"
  |Node (h, ag, _) -> if ag = Leaf then h else descendant_gauche ag

  let rec descendant_droit arbre=
  match arbre with
  |Leaf -> failwith"Il n'y a plus rien"
  |Node (h, _, ad) -> if ad = Leaf then h else descendant_droit ad

type 'a tree =
    | Noeud of 'a * 'a tree list

let etiquette_racine (Noeud(x,_)) = x

let liste_enfant (Noeud(_, l)) = l
*)

type 'a tree =
    |Empty
    |Node of 'a * 'a tree * 'a tree

let rec hauteur tree =
  match tree with
  |Empty -> 0
  |Node(h,Empty,Empty) -> 0
  |Node (h,ag,ad) -> 1 + max (hauteur ag) (hauteur ad)

let rec liste_sous_arbre tree =
  match tree with
  |Empty -> [tree]
  |Node(h,ag,ad) -> [ag]@[ad]@(liste_sous_arbre ag) @ (liste_sous_arbre ad)

let rec max_arbre tree =
  match tree with
  |Empty -> 0
  |Node(h,Empty,Empty) -> h
  |Node(h,ag,ad) -> if h > max (max_arbre ad) (max_arbre ag) then h
                    else max (max_arbre ad) (max_arbre ag)
