type 'a liste =
|Rien
|Liste of 'a * 'a liste

let rec taille l =
  match l with
  |Rien -> 0
  |Liste (_,q) -> 1 + taille(q)