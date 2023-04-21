(*Question 1*)
let rec vectoriser fonction lst =
  match lst with
  |[] -> []
  |h::t -> fonction h::vectoriser fonction t;;

(*Question 2*)
let est_pair h =
  h mod 2 = 0

(*Question 3*)
let rec select c l =
  match l with
  |[] -> []
  |h::t -> if c h then h::select c t else select c t

(*Quetion 4*)
let rec pour_tout p l =
  match l with
  |[] -> true
  |h::t -> if p h = false then false else pour_tout p t

