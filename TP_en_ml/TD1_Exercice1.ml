(*Question-2*)
let a = 25 * -18;;
let b = 2.25 /. 3.14;;
let c = 238.4 ** 5.0;;

(*Question-3*)
let norme x y = sqrt((x**2.0) +. (y**2.0));;

(*Question 5*)

let div_euclidienne a b = (a/b, a mod b);; 

(*Question 6*)

let rec puissance_entiere x n =
  if n = 0 then 1
  else if n = 1 then x
  else puissance_entiere x (n-1) * x  ;;

(*Question 7*)

let rec fib n =
  if n = 0 || n = 1 then 1
  else fib(n-1) + fib(n-2);;

(*Question 9*)
let rec aux a b n =
if n = 0 then (a+b)
else aux (a+b) a (n-1);;

let rec fib_eff n =
  aux 1 1 (n-2);;

(*Question 11*)

let rec suite_arth_geometrique a b n =
  if n = 0 then 0.
  else a *. (suite_arth_geometrique a b (n-1)) +. b;;

(*Question 12 : Nous ne sommes plus dans l'ensemble N*)

