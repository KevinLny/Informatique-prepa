(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 18 : Algorithmes de plus court chemin Floyd-Warshall     //
//  27/05/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*Fichier source du tp :*)

let creer_matrices n =
  Array.init (n + 1) (fun _ -> Array.make_matrix n n infinity)

let copie_matrice_dans m m' =
  let n = Array.length m in
  for i = 0 to n - 1 do
    for j = 0 to n - 1 do
      m'.(i).(j) <- m.(i).(j)
    done
  done

let exemple_cours =
  [|
    [| infinity; 10.; 5.; infinity; infinity |];
    [| infinity; infinity; 2.; 1.; infinity |];
    [| infinity; 3.; infinity; 9.; 2. |];
    [| infinity; infinity; infinity; infinity; 4. |];
    [| 7.; infinity; infinity; 6.; infinity |];
  |]

(*Exercice 1 – Propriétés de la distance restreinte*)

