#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Exercice 1

void affiche_tableau(int arr[], int deb, int fin) {
    printf("deb = %d, fin = %d :\n  [ ", deb, fin);
    for (int i = deb; i < fin; i++) {
        printf("%d ", arr[i]);
    }
    printf("]\n");
}

void swap(int* t, int x, int y){
    int temp = t[x];
    t[x] = t[y];
    t[y] = temp;
}

int partitionner_hoare(int* t, int deb, int fin){
    int pivot = t[deb];
    int j = deb+1;
    int i = fin-1;
    while(j<=i){
        if(t[j]>pivot){
            swap(t,j,i);
            i--;
        }else{
            j++;
        }
    }
    swap(t,deb,j-1);
    return j-1;
}

void tri_rapide_aux(int* t,int deb,int fin){
    if(fin - deb > 1){
        int new_pivot = partitionner_hoare(t,deb,fin);
        tri_rapide_aux(t,deb,new_pivot);
        tri_rapide_aux(t,new_pivot+1,fin);
    }
}

int* genere_tableau_aleatoire(int taille){
    int* p = malloc(taille*sizeof(int));
    for(int i=0;i<taille;i++){
        p[i] = rand() % 100;
    }
    return p;
}

//Exercice 4

//Q2. Si Taille du tab pair médiane = select(T,k/2)
//    Si Taille du tab impaire médiane = (select(T,k/2)+select(T,k-1/2))/2

//Q3.
int quickselect_aux(int* tab, int deb, int fin, int k){
        int pivot = t[deb];
    int j = deb+1;
    int i = fin-1;
    while(j<=i){
        if(t[j]>pivot){
            swap(t,j,i);
            i--;
        }else{
            j++;
        }
    }
    swap(t,deb,j-1);
    return j-1;

}


int main(void){
    int* tab = genere_tableau_aleatoire(20);
    affiche_tableau(tab,0,20);
    tri_rapide_aux(tab,0,20);
    affiche_tableau(tab,0,20);
    printf("helloWorld\n");
    free(tab);
    return 0;
}