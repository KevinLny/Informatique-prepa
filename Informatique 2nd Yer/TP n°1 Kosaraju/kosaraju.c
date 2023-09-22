#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

struct liste_adj {
    int tete;
    struct liste_adj* queue;
};
typedef struct liste_adj liste_adj_t;

struct graphe {
    int S; // nombre de sommets
    liste_adj_t **voisins; // tableau de liste d'ajacences
    // On pourra ajouter d'autres éléments si nécessaire.
};
typedef struct graphe graphe_t;

// QUESTION 0

void affiche_tableau (int taille, int* tableau){
    for(int i = 0; i<taille; i++){
        printf("%d", tableau[i]);
    }
};

// 1. Structure de données
// QUESTION 2

void initialiser_graph (graphe_t *g, int s){
    g->voisins = malloc(s * sizeof(liste_adj_t));
}

// QUESTION 3

struct liste {
    int elt;
    struct liste* suiv;
};
typedef struct liste noeud;

typedef struct {
    noeud* debut;
}pile;

void empiler(pile* p, int s){
    noeud* n = (noeud*) malloc(sizeof(noeud));
    n->elt = s;
    n->suiv = p->debut;
    p->debut = n;
}

int depiler(pile* p){
    if(p->debut != NULL){
        int d = p->debut->elt;
        noeud* temp = p->debut;
        p->debut = p->debut->suiv;
        free(temp);
        return d;
    }
    else {
    printf("Erreur pile vide");
    exit(1);
    }
}

// QUESTION 4



int main() {
    // On récupère le nombre de sommets et le nombre d'arrêtes
    // On les lit sur l'entrée standard
    int tab[3] = {1,2,3};
    affiche_tableau(3, tab);
    int S,A;
    scanf("%d %d", &S, &A);
    graphe_t *g = malloc (sizeof (graphe_t));
    // compléter la création du graphe
    //initialiser_graphe (g, S);
    
    //kosaraju (g);
    //affiche_composantes (g);

    return 0;
}
    
