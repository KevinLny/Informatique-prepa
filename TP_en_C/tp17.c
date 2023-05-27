//////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 17 : Manipulation de graphes en C                        //
//  17/05/2023                                                  //
//////////////////////////////////////////////////////////////////

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdbool.h>

// Exercice 1 – Cadre de travail, fonctions utilitaires

/*
Question 1:

Figure 2: On peut faire un chemin direct k ou avec des bouclettes de taille k'

Question 2: Soient 𝑥, 𝑦 ∈ 𝑆. Montrer que 𝑥 ⇒ 𝑦 ssi 𝑥 ⇒𝑛−1 𝑦.

⇒. Supposons 𝑥 ⇒ 𝑦 on a donc l'existence d'un chemin de x à y. 
    Ainsi il existe 𝑘 ∈ ℕ tel que 𝑥 ⇒ (indice k) y
    Soit G = (S,A) tel qu'il respecte les conditions cité. Avec |S| = n
    Supposons qu'un chemin de x à y soit c = (x,...,x(indice n-2),y)
    Sinon on passe k fois dans une bouclette pour atteindre un chemin de taille n-1.
    Ainsi on a un chemin tel que 𝑥 ⇒ indice(𝑛−1) 𝑦

⇒.  Supposons 𝑥 ⇒ indice(𝑛−1) 𝑦 donc d'après la définition
    𝑥 ⇒ 𝑦 on a donc l'existence d'un chemin de x à y

*/

// Question 3

bool** create_matrix(int n, int p){
    bool** tab = malloc(n*sizeof(bool*));
    for(int i = 0; i < n; i++){
        tab[i] = malloc(sizeof(bool)*p);
        }
    for(int i = 0; i<n; i++){
        for(int j = 0; j <p; j++){
            tab[i][j] = false;
        }
    }
    return tab;
}

void afficher_graphe(bool** m, int n, int p){
    for(int i = 0; i < n; i++){
        for(int j = 0; j < p; j++){
            printf("%d ",m[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("\n");
}

// Question 4

void free_matrix(bool** m, int n){
    for(int i = 0; i < n; i++){
        free(m[i]);
    }
    free(m);
}

// Question 5

bool** identity(int n){
    bool** tab = create_matrix(n,n);
    for(int i = 0; i < n; i++){
        tab[i][i] = true;
    }
    return tab;
}

// Question 6

bool** produit(bool** a, bool** b, int n, int p, int q){
    bool** tab_fin = create_matrix(n,q);
    for(int i = 0; i < n; i++){
        for(int j = 0; j < q; j++){
            for(int y = 0; y <p; y++){
                tab_fin[i][j] = tab_fin[i][j] || (a[i][y] && b[y][j]);
            }
        }
    }
    return tab_fin;
}

// Exercice 2 – Clôture transitive d’un graphe

/*
Question 1:

Question 2:
*/

//Question 3:

bool egaliter_matrix(bool** m1, bool** m2, int n){
    bool res = true;
    for(int i = 0; i < n; i++){
        for(int j = 0; j <n; j++){
            if(m1[i][j] != m2[i][j]){
                res = false;
            };
        }
    }
    return res;
}

bool** closure(bool** m, int n){
    bool** res = m;
    for(int i = 0; i <n; i++){
        res = produit(res, m, n, n, n);
    }
    return res;
}


int main(void){
    bool** mat1 = create_matrix(10,10);
    afficher_graphe(mat1,10,10);

    bool** mat2 = identity(10);
    afficher_graphe(mat2,10,10);

    bool** mat3 = produit(mat2, mat2, 10, 10, 10);
    afficher_graphe(mat3,10,10);

    bool** mat4 = closure(mat2,10);
    afficher_graphe(mat4,10,10);

    free_matrix(mat2, 10);
    free_matrix(mat1, 10);
    free_matrix(mat3, 10);
    free_matrix(mat4, 10);
    return 0;
}