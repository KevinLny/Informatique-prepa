(*////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 7 : Synchronisation et concurrence                    //
//  05/01/2024                                                  //
////////////////////////////////////////////////////////////////*)

(*
Notion importante à connaitre :

  - Utilisation de la bibliothèque pthread en C : #include <pthread.h>

  - Problème de l'exclusion mutuelle doit verifier ces deux propriétés :
    • Exclusion mutuelle : On a une seule tâche à la fois qui rentre dans sa section critique.
    • Absence d'interblocage : Si un processus cherche à rentrer dans sa section critique, 
    alors un processus (pas forcément le même) rentrera dans sa section critique dans tout les cas 

  - D'autre contrainte à ce problème :
    • Absence de famine : Tout processus qui veut entrer dans sa section critique y arrivera 
    • Attente bornée : Si un processus est bloqué dans sa section critique on peut borner la nombre 
    de fois ou les autres processus entrerons en section critique avant lui.

  - Processus a 4 états :
        • Section non critique
        • Entrer 
        • Section critique
        • Sorti

  - Algorithme de Petersen (Principe des barrières mais avec une prio pour évité les interblocage):
        tour := 0   b[0] = Faux    b[1] = Faux

        Entrer(i):
            b[i] = Vrai
            tour := i - 1
            Attendre b[1-i] = Faux ou tour = i
        
        Sortir(i):
            b[i] = Faux

        - Peterson satisfait :
                • Exclusion mutuelle
                • Absence d'interblocage
                • Absence de famine
    
  - Généralisons au cas n>= 2 fils (processus) Algorithme de la boulangerie de Lamport.
    On utilise un numéro de passage ou encore un tableau
    d'entier "numero" et d'un tab de booléen "choisis" qui indique si un fil est entrain de choisir son numéro

    On initialise choisi à Faux et numero à 0

        Entrer(i):
            choisi[i] := Vrai
            t := 0
            Pour j := 0 à n-1:
                t := max(t,numero[j])
            numero[i] := t+1
            choisi[i] := Faux
            Pour j := 0 à n-1:
                Attendre(choisi[j] = Faux)
                Attendre( numero[j] == 0 (numero[i],i)<= (numero[j],j) )
        
        Sortir(i):
            numero[i] := 0

       - Algorithme de la boulangerie de Lamport satisfait :
                • Exclusion mutuelle
                • Absence d'interblocage
                • Absence de famine
                • Premier arrivé, premier servis (FIFO)

  - Mutex permet de creer un verrous pour la section critique. Ce qui garentit l'expression mutuelle.

  - Sémaphores un entier qui est une sorte de variable global ou les processus peuvent le modifier.

*)