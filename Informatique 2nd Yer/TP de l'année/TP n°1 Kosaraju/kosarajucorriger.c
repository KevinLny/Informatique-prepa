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
    bool* vu; // pour le premier dfs
    int* compoForteConnex; // pour le second dfs
    // On pourra ajouter d'autres éléments si nécessaire.
};
typedef struct graphe graphe_t;

// Question 2

void initialiser_graphe (graphe_t* g, int S) {
    g->S =S;
    g->voisins = malloc ( S * sizeof (liste_adj_t*));
    g->vu = malloc ( S * sizeof (bool));
    g->compoForteConnex = malloc ( S * sizeof (int));
    for (int i = 0; i < S; i++) {
        g->voisins[i] = NULL;
        g->vu[i] = false;
        g->compoForteConnex[i] = -1;
    }
    g->ordre = malloc(sizeof(pile)); //On initialise avec la pile vide
    g->ordre->tete = NULL;
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
    free(g->compoForteConnex);
    free(g->vu);
    free(g->ordre);
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

graphe_t* renverse (graphe_t* g){
    graphe_t* revg = malloc(sizeof(graphe_t));
    int n = g->S;
    initialiser_graphe (revg, n);
    for (int i=0; i<n; i++){
        liste_adj_t* suivant = g->voisins[i];
        while (suivant != NULL){
            ajout_arete (revg, suivant->elem, i);
            suivant = suivant->suivant;
        }
    }
    revg->ordre->tete = g->ordre->tete; // On copie la pile (utile pour 7)
    return revg;;
}

// Question 6

void dfs (graphe_t* g, int s){
  // Parcours le graphe et empile les sommets
  g->vu[s] = true;
  liste_adj_t* pointeur_voisin = g->voisins[s];
  while (pointeur_voisin != NULL){
    int  v = pointeur_voisin->elem;
    if (!g->vu[v]) {
      dfs(g, v);
    }
    pointeur_voisin = pointeur_voisin->suivant;
  }
  empile (g->ordre, s);
}

void parcours_profondeur (graphe_t* g) {  
  for (int i = 0; i < g->S; i++){
    if (!g->vu[i]){
      dfs (g, i);
    }
  }
}

// Question 7

void dfs2 (graphe_t* g, int s, int couleur){
  // Parcours le graphe et colorie les sommets
  g->compoForteConnex[s] = couleur;
  liste_adj_t* pointeur_voisin = g->voisins[s];
  while (pointeur_voisin != NULL){
    int  v = pointeur_voisin->elem;
    if (g->compoForteConnex[v] == -1){
      dfs2 (g, v, couleur);
    }
    pointeur_voisin = pointeur_voisin->suivant;
  }
}

// On remarque le similarité avec l'algorithme précédent. On pourrait fusionner les 2
//      et n'avoir qu'un seul dfs avec plusieurs fonctionnalités.

// Question n° 8

void parcours_profondeur2 (graphe_t* g) {
  int couleur = 0;
  for(int i = 0; i < g->S; i++){
    int s = depile (g->ordre);
    if(g->compoForteConnex[s] == -1){
      dfs2 (g, s, couleur);
      couleur ++;
    }
  }
}


// Question n°9

void copie_cfc (graphe_t* g, graphe_t* revg){
  // copie les composantes connexes de revg dans g
  for(int i = 0; i<g->S; i++){
      g->compoForteConnex[i] = revg->compoForteConnex[i];
  }
}

void kosaraju (graphe_t* g){
  parcours_profondeur (g);
  graphe_t* revg = renverse (g);
  parcours_profondeur2 (revg);
  copie_cfc (g, revg);
  libere_graphe(revg);
}

//Question n°10

void affiche_composantes (graphe_t* g) {
  for(int i = 0; i<g->S; i++){
      printf("Le sommet n°%d est dans la composante fortement connexe n°%d \n", i, g->compoForteConnex[i]);
  }
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
//     graphe_t* revg = renverse (g);
//     pile* p = malloc(sizeof(pile));
//     empile (p,42);
//     empile (p,13);
//     a = depile (p);
//     b = depile (p);
//     printf("Les éléments dépilés sont : %d %d\n", a, b);
//     printf("Un voisin de 0 est : %d\n",((g->voisins)[0])->elem);
//     printf("Un voisin de 0 dans revg est : %d\n",((revg->voisins)[0])->elem);
//     libere_graphe (revg);
//     free(p);
    
    kosaraju (g);
    affiche_composantes (g);
    
    libere_graphe (g);
    
}
    