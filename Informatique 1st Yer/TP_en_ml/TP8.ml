type 'a tree =
    |Empty
    |Node of 'a * 'a tree * 'a tree


(*arbre 1*)

let arbre_1 = Node("A", Node("B",Empty,Empty), Node("C",Node("D",Empty,Empty),Node("E",Empty,Empty)))

(*Arbre 2*)

let arbre_2 = Node(3,Node(1,Empty,Empty),Empty)

(*Arbre 4095*)

let rec f h =
  if h = 0 then Empty
  else Node(h, f (h-1), f (h-1))

let rec hauteur tree =
  match tree with
  |Empty -> -1
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

let est_feuille tree =
  match tree with
  |Empty -> true
  |Node(h,Empty, Empty) -> true
  |Node(h, ag, ad) -> false

let rec nb_feuille tree =
  match tree with
  |Empty -> 0
  |Node(h, Empty,Empty) -> 1
  |Node(h,ag,ad) -> nb_feuille ag + nb_feuille ad

let rec somme_etiquette tree = 
  match tree with
  |Empty -> 0
  |Node(h, Empty, Empty) -> h
  |Node(h, ad, ag) -> h + somme_etiquette ad + somme_etiquette ag

let somme_feuille tree = 
  match tree with
  |Empty -> 0
  |Node(h, Empty,Empty) -> h
  |Node(h,ag,ad) -> nb_feuille ag + nb_feuille ad


(*[A;B;C;D;E]*)
let rec parcours_prefixe tree = 
  match tree with
  |Empty -> failwith"Estvide"
  |Node(h,Empty,Empty) -> [h]
  |Node(h, ag, ad) -> h::parcours_prefixe ag @ parcours_prefixe ad

let rec max_min_arbre tree = 
  match tree with
  |Empty -> failwith"Vide"
  |Node(h, Empty, Empty) -> h,h
  |Node(h,ag,ad) -> let maxag,minag = (max_min_arbre ag) in
                    let maxad,minad = (max_min_arbre ad) in
                    max h (max maxag maxad),min h (min minag minad)

let rec max_somme_branche tree =
  match tree with
  |Empty -> 0
  |Node(h,Empty,Empty) -> h
  |Node(h,ag,ad) -> h + max (max_somme_branche ag) (max_somme_branche ad)

let arbre_test = Node(10,Node(-1,Empty,Empty),Node(1,Empty,Empty))

type 'a arbre_strict =
  |Feuille of 'a
  |Noeud_interne of 'a arbre_strict * 'a * 'a arbre_strict

let arbre_1_stric = Noeud_interne(Feuille "B","A",Noeud_interne(Feuille"C","C",Feuille"E"))