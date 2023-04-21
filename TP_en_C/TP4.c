#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
// Exercice 1

int absolue(int x){
    if (x<=0){
        return -x;
    }else{
        return x;
    }
}

void figure(int n){
    
    printf("Forme 1");
    for(int k=0; k<n; k++){
        printf("*****\n");
    }
    
    printf("\nForme 2\n");
    for(int j=0; j<n; j++){
        for(int h=0; h<j; h++){
            printf("*");
        }
        printf("\n");
    }
    
    printf("\n\nForme 3\n");
    for(int l=0; l<n;l++){
        for(int m=l; m!=0; m--){
            printf("*");
        }
        printf("\n");
    }
}

void est_diviseur(int n){
    for(int k=1; k<n; k++){
        if(n%k == 0){
            printf("%d\n",k);
        }
    }
}

// Exercice 2

//Question 1

#define TAILLE_TABLEAU 25

int tab[TAILLE_TABLEAU]; // tableau entier non réaliser

void initialiser(void){
    for(int k=0; k<TAILLE_TABLEAU; k++){
        tab[k] = 0;
    }
}

void affiche(void){
    printf("Liste: [");
    for(int k=0; k<TAILLE_TABLEAU;k++){
        printf("%d",tab[k]);
        printf(";");
    }
    printf("]\n");
}

void initialiser_hasard(void){
    for(int k=0; k<TAILLE_TABLEAU; k++){
        tab[k] = rand();
    }
}

int indice_min(int debut, int fin){
    if(debut>fin && fin>25 && debut<0){
        return printf("Probleme...");
    }
    int min = tab[debut];
    int indice = debut;
    for(int k = debut; k<fin; k++){
        if(min>tab[k+1]){
            min = tab[k+1];
            indice = k+1;
        }
    }
    return indice;
}

int tri_selection(void){
    for(k=0;k<TAILLE_TABLEAU;k++){
        
    }
}

int main(void){

    printf("~~~~ Exercice 1 ~~~~\n\n");

    printf("La valeur absolue de: %d\n",absolue(-5));
    //figure(10);
    printf("Les diviseur de 100\n");
    est_diviseur(100);

    printf("~~~~ Exercice 2 ~~~~\n\n");

    initialiser();
    affiche();
    initialiser_hasard();
    affiche();
    printf("L'indice min : %d\n",indice_min(0,13));
    return 0;
}