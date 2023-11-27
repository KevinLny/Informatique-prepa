(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 8 : Automate de Glushkov                                 //
//  24/11/2023                                                  //
////////////////////////////////////////////////////////////////*)

type automate = {n : int ; t : bool array ; delta :  (int*char*int) list };;

type exprat =
    | Lettre of char
    | Lettre_n of char*int (* pour l'expression linéarisée *)
    | Union of exprat * exprat
    | Concat of exprat * exprat
    | Etoile of exprat ;;  

(*I.Linéarisation d'une expression rationnelle*)

let exemple = Concat(Etoile(Union(Concat(Lettre('a'),Lettre('b')), Lettre('b'))),Concat(Lettre('b'), Lettre('a')))

let rec lineariser exp compt =
  match exp with
  | Lettre c -> Lettre_n (c , compt) , compt+1
  | Union (c1,c2) -> let l1 = lineariser c1 compt in let l2 = lineariser c2 (snd l1)
  in
  Union (fst l1 , fst l2), snd l2
  | Concat (c1,c2) -> let l1 = lineariser c1 compt in let l2 = lineariser c2 (snd l1)
  in 
  Concat (fst l1 , fst l2), snd l2
  | Etoile (c) -> let l =lineariser c compt 
  in Etoile(fst(l)), snd l
  | _ -> exp,compt

(*II. Calcul des ensembles P, S et F*)

let rec motvide exp =
  match exp with
  | Lettre _ -> false
  | Lettre_n _-> false
  | Union (c1,c2) -> motvide c1 || motvide c2
  | Concat (c1,c2) -> motvide c1 || motvide c2
  | Etoile c -> true || motvide c

let rec union set1 set2 = 
  match set1,set2 with
  | [],[] -> []
  | h::t , [] | [], h::t -> h::t
  | h1::t1, h2::t2 -> if h1 > h2 then union t1 (h2::t2) else union t2 (h1::t2) 
