(*Exercice 1*)

(*Q1*)

type  formule = 
| Prop of int 
| Non of formule 
| Et of  formule * formule
| Ou of formule * formule 
| Impl of formule *formule 
| Vrai
| Faux

type valuation = bool array

let tab = [|true;false;true;false|]

(*Q2*)

let phi = Impl( Ou(Faux,Prop 1), Et(Ou(Et(Non(Prop 1),Prop 2),Prop 0),Impl(Vrai,Ou(Prop 2,Prop 3))))

(*Phi de Taille 16 et de hauteur 5*)

(*Q3*)

let rec taille prop = 
  match prop with
  | Prop int -> 1
  | Non (a) -> 1 + taille a
  | Et (a,b) | Ou (a,b) | Impl (a,b) -> 1 + taille a + taille b
  | Vrai | Faux -> 1

(*Q4*)

let rec ind_var_max prop =
  match prop with
  | Prop i -> i
  | Non (a) -> ind_var_max a
  | Et (a,b) -> max (ind_var_max a) (ind_var_max b)
  | Ou (a,b) -> max (ind_var_max a) (ind_var_max b)
  | Impl (a,b) -> max (ind_var_max a) (ind_var_max b)
  | Vrai -> -1
  | Faux -> -1

(*Q5*)

let rec valeur_verite prop tab =
  match prop with
  | Prop i -> tab.(i)
  | Non (a) -> not (valeur_verite prop tab)
  | Et (a,b) -> (valeur_verite a tab) = (valeur_verite b tab)
  | Ou (a,b) -> (valeur_verite a tab) || (valeur_verite b tab)
  | Impl (a,b) -> not(valeur_verite a tab) || (valeur_verite b tab)
  | Vrai -> true
  | Faux -> false

(*Exercice 2*)

(*Q1*)

let incrementer_valuation tab =
  let temp = ref(true) in
  for i = 0 to Array.length tab do
    if !temp = true then
      if tab.(i) = false then
      begin
        tab.(i) <- true;
        temp := false;
      end 
      else tab.(i) <- false;
  done;;

let tab_test = [|true;true;true|]
(*Q2*)

let test = Et(Prop 0, Prop 1)

let satisfiable_brute prop =
  let temp = ref(false) in 
  let tab = Array.make ((ind_var_max prop)+1) false in
  while true do
  try
    if valeur_verite prop tab = true then temp := true;
    incrementer_valuation tab;
  with Not_found -> temp := false
  done;
  !temp