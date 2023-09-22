type 'a tree =
|Vide
|Node of 'a tree* 'a * 'a tree

let arbre_rech = Node(Node(Node(Vide,5,Vide),10,Node(Vide,8,Vide)),20,Node(Node(Vide,25,Vide),30,Node(Vide,35,Vide)))
let arbre_ez = Node(Node(Vide,4,Vide),10,Node(Vide,11,Vide))
let rec max_arbre tree =
  match tree with
  |Vide -> 0
  |Node(Vide,h,Vide) -> h
  |Node(ag,h,ad) -> if h > max (max_arbre ad) (max_arbre ag) then h
                    else max (max_arbre ad) (max_arbre ag)

let rec min_arbre tree =
  match tree with
  |Vide -> 0
  |Node(Vide,h,Vide) -> h
  |Node(ag,h,ad) -> if h < min (min_arbre ad) (min_arbre ag) then h
                    else min (min_arbre ad) (min_arbre ag)
                    
let rec est_abr tree = 
  match tree with
  |Vide -> true
  |Node(Vide,e,Vide) -> true
  |Node (g,e,d) -> if e < max_arbre d && e > min_arbre g then est_abr g && est_abr d 
                   else false
