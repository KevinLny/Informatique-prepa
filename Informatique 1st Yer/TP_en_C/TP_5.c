#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

void echange_entier(int *x, int *y){
    int temp = *x;
    *x = *y;
    *y = temp;
}

void fonction_mystere(int* x, int* y){
    *x = *x - *y;
    *y = *x + *y;
    *x = *y - *x;
}

int* creer_tableau(int n, int v){
    int* p = malloc(sizeof(int)*n);
    for(int k = 0; k<n; k++){
        p[k] = v;
    }
    return p;
}

void afficher(int* p, int n){
    printf("[");
    for(int k=0; k<n; k++){
        printf("%d,",p[k]);
    }
    printf("]\n");
}

struct S {int a; double b; char* c;};
struct S s = {.a = 25, .b = 1.1, .c = "Bonjour !"};

struct COMPLEXE {int Re; int Im;};
struct COMPLEXE z = {.Re = 10, .Im = 5};

void conjugaison(int* Im){
    *Im = -*Im;
}



int main(void){
    printf("Hello world!\n");

    // Exercice 1
    printf("~~~~Exercice 1~~~~\n\n");
    int k = -25;
    int* ptr_k = NULL;
    ptr_k = &k;
    k = 24;
    printf("%d\n",k);
    *ptr_k = *ptr_k + 1;
    printf("%d\n",k);

    //Exercice 2
    printf("~~~~Exercice 2~~~~\n\n");
    int x = 10;
    int y = 20;

    int* ptr_x = &x;
    int* ptr_y = &y;

    echange_entier(ptr_x,ptr_y);
    printf("%d;%d\n",x,y);

    //Exercice 3
    printf("~~~~Exercice 3~~~~\n\n");
    int f = 5;
    int d = 5;

    fonction_mystere(&f,&d);
    printf("%d;%d\n",f,d);

    //Exercice 4
    printf("~~~~Exercice 4~~~~\n\n");
    double l = 0.1 +0.2;
    printf("%ld\n",sizeof(l));
    printf("%f\n",l);
    double* flottant = malloc(sizeof(double));
    *flottant = 1.0;
    printf("%f\n",*flottant);
    free(flottant);

    int* lst = creer_tableau(20,1);
    afficher(lst, 20);
    free(lst);
    
    // Exercice 5
    printf("%d\n",s.a);
    printf("%f\n",s.b);

    int* ptr_Re = &z.Re;
    int* ptr_Im = &z.Im;
    int* ptr_z = (&z.Re,&z.Im);

    printf("Re(%d) + Im(%d)\n", *ptr_Re, *ptr_Im);
    conjugaison(ptr_Im);
    printf("Re(%d) + Im(%d)\n", *ptr_Re, *ptr_Im);
    return 0;
}