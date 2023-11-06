(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 3 : Couplage dans un graphe biparti.                     //
//  29/09/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*Données*)

let g0 = [|[|true; true; true; false|]; [|true; false; false; true|];   [|true; true; true; true|];
[|false; false; false; true|]; [|false; false; false; true|]|] ;;

let c = [|0; 3; 2; -1; -1|] ;; 

(*Partie 1 - Représentation des graphes bipartis*)

(*Question 1*)

let verifie g c =  let temp = ref(0) in
  let rep = ref true in
  let vu = Array.make (Array.length c) false
  in
  for i = 0 to (Array.length c) -1 do
    if c.(i) <> -1 then begin
      if vu.(c.(i)) = true || g.(i).(c.(i)) = false then 
        rep := false
      else
        vu.(c.(i)) <- true
    end
  done;
  !rep 

(*Question 2*)

let parcours_prof g c r =
