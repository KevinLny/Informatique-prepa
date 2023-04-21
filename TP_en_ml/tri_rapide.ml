let choix_pivot tab fin deb =
  tab.(fin-1)

let swap t i j =
  let temp = t.(i) in
  t.(i) <- t.(j);
  t.(j) <- temp

let partition tab fin =
  let pivot = tab.(fin-1) in
  let curseur =ref(0) in
  for i = 0 to fin-2 do
    if tab.(i) <= pivot then 
      begin
        swap tab i !curseur;
        curseur := !curseur + 1;
      end
    done;
    swap tab !curseur (fin-1);
    !curseur;;

let rec tri_rapide tab deb fin =
  if fin - deb > 1 then
    let new_pivot = partition tab fin in
    tri_rapide tab deb new_pivot;
    tri_rapide tab new_pivot fin

let test = [|6;7;3;4;8;1;5|]