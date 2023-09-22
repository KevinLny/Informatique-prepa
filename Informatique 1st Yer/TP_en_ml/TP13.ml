type position = { x : float; y : float }

let distance a b =
  sqrt((a.x**2. -. b.x**2.) +. (a.y**2. -. b.y**2.))

let a = {x = 3.; y = 4.}
let b = {x = 2.; y = 3.}
let c = {x = 1.; y = 3.}
let d = {x = 0.; y = 3.}

let test = [a;b;c;d]

(*Complexité en O(n²)*)

type nuage = position list

(*Alternaive*)

let rec divise lst =
  match lst with
  |[] -> [],[]
  |h::[] -> lst,[]
  |h::h2::c -> let (l1, l2) = divise c in h::l1, h2::l2

let rec fusionne lst1 lst2 =
  match lst1,lst2 with
  | [],_ -> lst2
  | _,[] -> lst1
  |h1::t1 , h2::t2 -> if h1.x<h2.x then h1::fusionne t1 lst2 else h2::fusionne lst1 t2

let rec trier_selon_x_bis cloud =
    match cloud with
    |[] -> []
    |h::[] -> cloud
    |h::a -> fusionne (trier_selon_x_bis (fst (divise cloud))) (trier_selon_x_bis (snd (divise cloud)))

(*Version question*)

let compare a b  =
  if a.x = b.x then 0
  else if a.x > b.x then 1
  else -1

let trier_selon_x nuage =
  List.sort compare nuage


let rec plus_petit_d cloud =
  match cloud with
  | [] -> failwith"aucun element"
  | [x] -> failwith"1 element"
  | [x1;x] -> distance x1 x
  | h1::h2::t ->if distance h1 h2 > plus_petit_d t then plus_petit_d t else distance h1 h2
  
let dmin_deux_listes cloud1 cloud2 =
  if plus_petit_d cloud1 > plus_petit_d cloud2 then plus_petit_d cloud1 else plus_petit_d cloud2
