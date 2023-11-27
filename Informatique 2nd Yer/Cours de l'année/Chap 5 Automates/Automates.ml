(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 5 : Automates                                         //
//  27/11/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - Un Automates fini déterministe A sur l'alphabet Σ , A = (Σ, Q, q0, F,δ)
    • Q -> Ensemble fini d'états
    • q0 ∈ Q -> l'état initial
    • F ⊆ Q -> Ensemble des états finaux (ou acceptant)
    • δ -> fonction de Q x Σ -> Q appelé fonction de transition de l'automate

  - Un mot m est reconnu par A s'il existe un chemin q0 à un état final étiqueté par m

  - La fonction de transition δ* s'étend aux mots Q x Σ* -> Q

  - L(A) = {m|δ*(q0,m) ∈ F}

  - Un automates est non déterministe s'il y a 2 transition possible pour le noeud

  - Un automates est complet si sur chaque noeud il y a une transition pour chaque lettre de Σ

  - Un état q ∈ Q est accessible s'il existe m ∈ Σ* tel que δ*(q0,m) = q
  - Un état q ∈ Q est co-accessible s'il existe m ∈ Σ* tel que δ*(q0,m) ∈ F
    • Un automate est EMONDE si tous ses états sont accessible et co-accessible

    
  

*)