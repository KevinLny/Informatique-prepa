(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 4 : Langages et expression régulières                 //
//  27/11/2023                                                  //
////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - Soit L et L' deux langages sur l'alphabet Σ
    -> L.L' = { uv | u ∈ 𝐿 et 𝑣 ∈ 𝐿′ }
  - Soit Σ un alphabet. Les langages réguliers sont les langages défini par induction:
    • Les langages  ∅, {ε}, {𝑎}pour tout 𝑎 ∈Σ, sont réguliers.
    • La concaténation, l'union, l'étoile de Kleene de langages réguliers sont réguliers.

  - Morphismes :
    • Soit Σ1, Σ2 deux alphabets et 𝜑 : Σ∗1 −→Σ∗2 une fonction. 𝜑 est un morphisme si pour tous mots u, v 𝑢, 𝑣 ∈Σ∗1, on a 𝜑(𝑢𝑣) =𝜑(𝑢)𝜑(𝑣)
    • Soit 𝑒 une expression régulière sur l’alphabet Σ et 𝜑 : Σ →Σ alors L(𝜑(𝑒)) =𝜑 (L(𝑒))


*)