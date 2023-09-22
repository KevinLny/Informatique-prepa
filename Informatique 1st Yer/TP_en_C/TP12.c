#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

// Exercice 1

// Q1

int g[9][9] = {
    {2,5,0,0,3,0,9,0,1},
    {0,1,0,0,0,4,0,0,0},
    {4,0,7,0,0,0,2,0,8},
    {0,0,5,2,0,0,0,0,0},
    {0,0,0,0,9,8,1,0,0},
    {0,4,0,0,0,3,0,0,0},
    {0,0,0,3,6,0,0,7,2},
    {0,7,0,0,0,0,0,0,3},
    {9,0,3,0,0,0,6,0,4},
};

// Q2

void afficher_grille(int grille[9][9]){
    for (int i = 0; i<9; i++){
        printf("|");
        for(int k = 0;k<9; k++){
            if( grille[i][k] == 0 ){
                printf(" |");
            }
            else{
                printf("%d|",grille[i][k]);
            }
        }
        printf("\n");
    }
}

// Q3

void suivant(int grille[9][9], int i, int j, int* x, int* y){
    bool temp = false;
    for(int f = i; f<9;f++){
        if(grille[abs(j-8)][i] == 0){
            *y = abs(i-8);
            *x = f;
            temp = true;
        }
    }
    int n = abs(j-7);
    while( !temp && n > 9){
        for(int k = 0; k<9; k++){
            if(grille[n][k] == 0){
                *y = n;
                *x = abs(k-9);
                temp = true;
            }
        }
    }
}

int main(void){
    printf("Hello world\n");
    printf("%d\n", abs(-1));
    afficher_grille(g);
    
    int x = 0;
    int y = 0;

    int* ptr_x = &x;
    int* ptr_y = &y;

    suivant(g,0,0,ptr_x,ptr_y);
    printf("x : %d, y : %d\n",x,y);
    return 0;
}