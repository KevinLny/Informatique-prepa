//////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  Cours 3 : Couplage maximum dans un graphe biparti           //
//  30/09/2023                                                  //
//////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//                                                              //
//                   Couplage biparti maximum                   //
//                                                              //
//////////////////////////////////////////////////////////////////

/*
Notion importante à connaitre :

* Couplage maximum:

  - Un couplage dans un grapge G = (S,A) est un ensemble d'arêtes C tel 
  que chaque sommet soit incident à au plus une arête de C.
  Soit (u,v) ∈ C, on dit que u et v sont couplés.

  - Un graphe est biparti si l'on peut le partitionner en S1 et S2, tel
  que A ⊆ S1 x S2

  - Un couplage est dit maximum s'il contient le plus grand nombre 
  d'arêtes possible et il est dit parfait s'il couvre tout les sommets
  
* Chemin augmentant:

  - Un chemin augmentant est un chemin élémentaire dont les extrémités 
  ne sont pas couvertes et dont les arêtes apparitiennent alternativement
  à A\C et à C.

  - Soit C un couplage dans un graphe G et P un chemin augmentant, P désigne
  la suite de sommets et d'arêtes. Alors C' = C Δ P = (C U P)\(C ∩ P) est 
  un couplage et |C'| =|C| + 1
  Δ est l'opérateur de différence symétrique.

  - Soit C,C' deux couplage dans un graphe G = (S,1) avec |C'| > |C|. Alors,
  C possède un chemin augmentant.

  - Un couplage est maximum ssi in ne contient pas de chemin augmentant.

* Algorithme:

  - Soit G = (S,A) graphe biparti avec S = S1 U S2 et A = S1 x S2. C un couplage:
    
    i. Un chemin augmentant de G a une extrémité dans S1 et l'autre dans S2.
    
    ibis. On oriente les arêtes de C de S2 vers S1 et les arêtes de	A\C de S1 vers S2
    pour obtenir G'
    
    ii. Un chemin augmentant de G devient un chemin de G' d'un sommet de S1 non couplé
    à un sommet de S2.

    iii. Un chemin de G' d'un sommet non couplé de S1 à un sommet non couplé S2 est un
    chemin augmentant de G.
    (On peut donc déterminer si un graphe biparti admet un chemin augmentant à l'aide 
    d'un parcours de graphe.)

  - Pour trouver un couplage maximum:
    On part d'un couplage vide. Ensuite on cherche un chemin augmentant et on augmente
    le couplage. Puis on recommence tant que c'est possible.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Nombre maximum de sommets

#define MAXS 100

typedef struct liste {
    int v;              // Le voisin
    struct liste* suite // La suite de la liste
} liste;

typedef struct bigraphe {
    liste * adjacence[MAXS]; //Le tableau de liste d'adjacence
    int nsommets;
    bool visite[MAXS];
    int couple[MAXS];        // Indique pour chaque sommet, le sommet avec lequel il est couplé
    int npartiel;            // Les sommets de la première partie sont les npartiel premiers  
} bigraphe;


void ajoute_arete (bigraphe* g, int u, int v){
    liste* voisin = malloc(sizeof(liste));
    voisin -> v = v;
    voisin -> suite = g -> adjacence[u];
    g -> adjacence[u] = voisin;
}

void initialiser_bigraphe (bigraphe* g,int n, int npartiel){
    for(int i = 0; i <n; i++){
        g -> adjacence[i] = NULL;
        g -> couple[i] = -1;
        g -> visite[i] = false;
    }
    g -> sommets = n;
    g -> npartiel = npartiel;
}

void affiche_couple (bigraphe* g){
    for(int i = 0; i <g->nsommets; i++){
        printf("Le sommet %i est couplé avec %i.\n", i, g->couple[i]);
    }
}

bool chemin_augmentant (bigraphe* g, int u){
    liste *voisin = g-> adjacence[u];
    while(voisin != NULL){
        if(!g -> visite[voisin->v]){
            g -> visite[voisin->v] = true;
            if( (g -> couple[voisin->v] == -1) || (chemin_augmentant (g, g->couple[voisin->v]))){
                g -> <couple[u] = voisin -> v;
                g -> couple[voisin->u] = u;
                return true;
            }
        }
        voisin = voisin-> suites;
    }
    return false;
}

void couplage_maximum_biparti (bigraphe* g){
    bool b = true;
    while (b){
        b = false;
        for(int i = 0; i<g->nsommets; i++){
            g->visite[i] = false;
        }
        for(int i = 0; i<g->npartiel; i++){
            if(g->couple[i] == -1){
                b = chemin_augmentant(g,i) || b;
            }
        }
    }
}

// Exemple
int main (){
    int n = 6;
    int m = 3;
    bigraphe* g = malloc(sizeof(bigrap));;
    initialiser_bigraphe(g, n, m);
    ajoute_arete(g, 0, 5);
    ajoute_arete(g, 0, 4);
    ajoute_arete(g, 0, 3);
    ajoute_arete(g, 1, 3);
    ajoute_arete(g, 2, 4);
    ajoute_arete(g, 2, 5);
    couplage_maximum_biparti(g);
    affiche_couple(g);
    return 0;
}