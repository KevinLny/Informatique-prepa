(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 6 : Automates et Langages Reguliers                   //
//  27/11/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - Soit L un langage sur l'alphabet Σ :
    • P(L) = { a ∈ Σ | aΣ* ∩ L =! ∅}, l'ensemble des premieres lettres pour L
    • S(L) = { a ∈ Σ | Σ*a ∩ L =! ∅ }, l'ensemble des dernières lettres pour L
    • F(L) = { u ∈ Σ² | Σ*uΣ* ∩ L =! ∅ }, l'ensemble des mots de longueur 2 pour L
    • N(L) = Σ²\F(L), ensemble des mots de longueur 2 non présent dans L

  - On a L\{ε} ⊆ (P(L)Σ* ∩ Σ*S(L))\ (Σ*N(L)Σ*)
    -> L est locale si on a l'égalité

  - Soit L1 et L2 deux langages locaux defini sur Σ1 et Σ2
    -> Si Σ1 ∩ Σ2 = ∅ alors sur l'alphabet Σ = Σ1 U Σ2
        • L1 et L2 sont encore Locaux
        • L1 U L2 est local 
        • L1.L2 est local 

  - Une expression est linéaire si chaque lettre apparaît au plus une fois dans e 
  - Soit e une expression régulière, si e est linéaire alors L(e) est un langage local

  - Soit A un automate sur l'alphabet Σ et 𝜑 : Σ -> Σ' alors 𝜑(L(A)) = L(𝜑(A))

  - Lemme de l'Etoile Soit L le langage reconnu par un automate à n états. 
    Pour tout u ∈ L tel que |u| <= n, il existe x,y,z tel que u = xyz:
    • |xy| <= n, il existe
    • y != ε
    • xy*z ⊆ L 

*)