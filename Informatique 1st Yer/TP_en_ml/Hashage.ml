type ('a ,'b)dicthas = ('a * 'b)list array

(*Fonction de Haché*)
let hache_chaine s =
  (String.length s) * 255 mod 101
  

let creer_dic n = Array.make n[]


let add_bis lst cle valeur =
  (cle,valeur)::lst

let add dict mot =
  add_bis dict.(hache_chaine mot)

let rec rechcerche_bis lst mot =
  match lst with
  |[]-> false
  |(a,b)::t -> if b = mot then true else rechcerche_bis t mot

let recherche dict mot =
  rechcerche_bis dict.(hache_chaine mot)

