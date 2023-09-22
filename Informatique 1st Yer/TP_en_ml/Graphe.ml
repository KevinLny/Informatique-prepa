

let exemple_sans_ponderation =
  [|
   [| false; true; true; false; true|];
   [| false; false; false; false; false|];
   [| false; true; false; true; true|];
   [| true; false; false; false; true|];
   [| false; false; true; false; false|];
  |]

let mat_euler =
  [|
    [|false;true;false|];
    [|true;false;|];
  |]

let parcours_prof g s =
  let est_visite = Array.make (Array.length g) false in
  let rec voisin x =
    if not est_visite.(x) then
      est_visite.(x) <- true;
      for y = 0 to Array.length g - 1 do
        if g.(x).(y) then 
          begin
             est_visite.(y) <- true; 
             voisin y;
          end
      done;
  in
  voisin s; 
  for i = 0 to Array.length est_visite -1 do
    if est_visite.(i) then print_int(i)
  done;;

let is_eulerien g =
  let taille = Array.length g in
  let bool = ref(false) in
  for i = 0 to taille - 1 do
    if !bool then begin
    let somme = ref(0) in
    for y = 0 to Array.length g.(i) - 1 do
      if g.(i).(y) then somme := 1 + !somme
    done;
    if !somme mod 2 <> 0 then bool := false
    end
    done;
    !bool

