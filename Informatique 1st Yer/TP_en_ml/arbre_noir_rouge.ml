type 'a tree_2_3 =
  | Vide
  | Node of 'a tree_2_3 * 'a * 'a tree_2_3
  | M of 'a tree_2_3 * 'a * 'a tree_2_3 * 'a * 'a tree_2_3

type couleur = R | N

type 'a redblacktree =
  | Vide
  | Noeud of 'a * couleur * 'a redblacktree * 'a redblacktree


let arbreRN = Noeud(13,N,Noeud(8,R,Noeud(1,N,Vide,Noeud(6,R,Vide,Vide)),Noeud(11,N,Vide,Vide)),Noeud(17,R,Noeud(15,N,Vide,Vide),Noeud(25,N,Noeud(15,R,Vide,Vide),Noeud(27,R,Vide,Vide))))

let arbreRN1 = Noeud(10,N,Noeud(3,R,Noeud(1,R,Vide,Vide),Vide),Noeud(15,R,Vide,Vide))


let couleur_noeud tree =
  match tree with
  | Vide -> N
  | Noeud (_,color,_,_) -> color

let rec min_abr abr =
  match abr with
  |Vide -> failwith"Vide1"
  |Noeud(e,color,Vide,Vide) -> e
  |Noeud(e,color,g,d) -> min_abr g


let rec max_abr abr =
  match abr with
  |Vide -> failwith"Vide2"
  |Noeud(e,color,Vide,Vide) -> e
  |Noeud(e,color,g,d) -> max_abr d


let rec recherche abr valeur =
  match abr with
  | Vide -> false
  | Noeud(e,_,g,d) -> e = valeur || if e > valeur then recherche g valeur 
                              else recherche d valeur


let rec est_redblacktree tree =
  let etiquette_arbre tree =
    match tree with
    | Vide -> N
    | Noeud (e,color,g,d) -> color in 
  match tree with
  | Vide -> true
  | Noeud(e,color,Vide,Vide) -> true
  | Noeud(e,R,Vide,d) -> e < min_abr d && if etiquette_arbre d = N then est_redblacktree d else false
  | Noeud(e,R,g,Vide) -> e > max_abr g && if etiquette_arbre g = N then est_redblacktree g else false
  | Noeud(e,R,g,d) -> e > max_abr g && e < min_abr d && if etiquette_arbre g = N && etiquette_arbre d = N then est_redblacktree g && est_redblacktree d else false
  | Noeud(e,N,g,Vide) -> e > max_abr g && est_redblacktree g
  | Noeud(e,N,Vide,d) -> e < min_abr d && est_redblacktree d
  | Noeud(e,N,g,d) -> e > max_abr g && e < min_abr d && est_redblacktree g && est_redblacktree d

