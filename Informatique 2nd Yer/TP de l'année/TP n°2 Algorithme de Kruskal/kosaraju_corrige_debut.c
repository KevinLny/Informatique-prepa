#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

//Question 0

void affiche_tableau (int taille, int* tableau){
    for (int i=0; i < taille; i++){
            printf("%d ", tableau[i]);
    }
    printf("\n");
}

//Question 1

struct liste_adj {
    int elem;
    struct liste_adj* suivant;
};
typedef struct liste_adj liste_adj_t;

struct pile {
    struct liste_adj* tete;
};
typedef struct pile pile;

struct graphe {
    int S; // nombre de sommets
    liste_adj_t **voisins; // tableau de liste d'ajacences
    pile* ordre; // Pile pour mettre l'ordre postfixe
    // On pourra ajouter d'autres éléments si nécessaire.
};
typedef struct graphe graphe_t;

// Question 2

void initialiser_graphe (graphe_t* g, int S) {
    g->S =S;
    g->voisins = malloc ( S * sizeof (liste_adj_t*));
    for (int i = 0; i < S; i++) {
        g->voisins[i] = NULL;
    }
    g->ordre = NULL;
}

void libere_graphe (graphe_t* g) {
    int S = g->S;
    for (int i=0; i<S; i++){
        liste_adj_t* suivant = g->voisins[i];
        while (suivant != NULL){
            liste_adj_t* tmp = suivant;
            suivant = suivant->suivant;
            free(tmp);
        }
    }
    free(g->voisins);
    free(g);
}

//Question 3

void empile (pile* p, int elem) {
    liste_adj_t *new_head = malloc(sizeof(liste_adj_t));
    new_head->elem = elem;
    new_head->suivant = p->tete;
    p->tete = new_head;
}

int depile (pile* p) {
    liste_adj_t* old_head = p->tete;
    int tmp = old_head->elem;
    p->tete = old_head->suivant;
    free (old_head);
    return tmp;
}

//Question 4

void ajout_arete ( graphe_t* g, int i, int j) {
    liste_adj_t *new_voisin = malloc(sizeof(liste_adj_t));
    new_voisin->elem = j;
    new_voisin->suivant = g->voisins[i];
    g->voisins[i] = new_voisin;
}

// Question 5

graphe_t* transpose (graphe_t* g){
    graphe_t* graphe_transpo = malloc(sizeof(graphe_t));
    int S = g->S;
    initialiser_graphe(graphe_transpo, S);
    for (int i=0; i<S; i++){
        liste_adj_t* suivant = g->voisins[i];
        while (suivant != NULL){
            ajout_arete(graphe_transpo, suivant->elem, i);
            suivant = suivant->suivant;
        }
    }
    return graphe_transpo;
}

int main() {
    int S,A;
    scanf("%d %d", &S, &A);
    graphe_t *g = malloc (sizeof (graphe_t));
    // compléter la création du graphe
    initialiser_graphe (g, S);
    int a,b;
    for (int i=0; i< A; i++){
        scanf("%d %d", &a, &b);
        ajout_arete (g, a, b);
    }
    
    //tests
    pile* p = malloc(sizeof(pile));
    empile (p,42);
    empile (p,13);
    a = depile (p);
    b = depile (p);
    printf("Les éléments dépilés sont : %d %d\n", a, b);
    printf("Un voisin de 0 est : %d\n",((g->voisins)[0])->elem);
    graphe_t* revg = transpose (g);
    //fin des tests
    
    //kosaraju (g);
    //affiche_composantes (g);
    
    libere_graphe (g);
    //libere_graphe (revg);
    free(p);
}
    
