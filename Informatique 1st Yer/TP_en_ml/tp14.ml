(*Exercice 1*)

let rec fibonnacci n =
  if n < 2 then 1
  else fibonnacci (n-1) + fibonnacci (n-2)

(*Question 2*)

let fib_descendant n =
  let t = Array.make (n+1) None in
    t.(0) <- Some 1;
    t.(1) <- Some 1;
    let rec fib k = (* int -> int *)
    match t.(k) with
    | Some v -> v (* on avait déjà calculé [fib k] *)
    | None -> let stock = fib (k-1) + fib (k-2) in t.(k) <- Some stock;stock
  in fib n;;

(*Question 3
Complexité temporelle en O(n) complexité spatiale en O(taille du tableau)   
*)

(*Question 4*)

let fib_ascendante n =
  let t = Array.make (n+1) 0 in
  t.(0) <- 1;
  t.(1) <- 1;
  let fib k =
  t.(k) <- t.(k-1) + t.(k-2)
  in 
  for i = 2 to n do
    fib i;
  done;
  t.(n)

(*Questoin 5*)

(*Exercice 2*)

(*Question 1
  Il y aura n(n+1)/2 sommes differentes en fonction de n  
*)

(*Question 2

def algo_naive (tableau):
  On definie max = t[0]
  j = 0
  Tant que j != Taille du tableau alors:
    i=0
    sum = 0
    Pour f = 0 a taille du tableau
      pour k = i à j faire:
        sum = sum + t[i]
      fini
      Si max < sum alors sum = max
      i = i +1
    fini
    j+1
  fini
  sum
*)

(*Question 3*)

let somme_sous_tableau tab i j =  (*i = deb j = fin -1*)
  let somme = ref(0) in
  for k=i to j-1 do
    somme := !somme + tab.(k)
  done;
  !somme
let test = [|1;2;3;4;5|]

let max_somme_contigue_exhaustive tab =
  let max_trouve = ref(tab.(0)) in
  let n = Array.length tab  in
  for l = 1 to n do
    for i = 0 to n-1 do
      max_trouve := max !max_trouve (somme_sous_tableau tab i l)
    done
  done;
  !max_trouve

(*Question 4
  En O(n^3)  
*)

let tabbis = [|13;-3;-25;20;-3;-16;-23;18;20;-7;12;-5;-22;15;-4;7|]

(*Question 5*)

let rec f tab i =
  if i = Array.length tab - 1 then tab.(Array.length tab -1)
  else tab.(i) + (max (f tab (i+1)) 0)

(*Question 6*)

let make_some_f_i tab =
  Array.init (Array.length tab) (fun i -> f tab i)

(*Question 7*)

let max_array tab =
  let max = ref(0) in
  for i = 0 to Array.length tab -2 do
    if !max<tab.(i) then max := tab.(i);
  done;
  !max

let max_somme_contigue_naive 