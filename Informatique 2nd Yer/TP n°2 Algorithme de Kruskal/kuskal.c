//////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 2 : Algorithme de Kruskal                                //
//  22/09/2023                                                  //
//////////////////////////////////////////////////////////////////

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

// I - Unir & Trouver

// Question 1
struct uf_elt {
    int val;
    int rang;
    struct uf_elt* parent;
};

typedef struct uf_elt  uf_elt;

// Question 2

uf_elt* creerElement(int val){
    uf_elt* elt = malloc(sizeof(uf_elt));
    elt->val = val;
    elt->parent = NULL;
    elt->rang = 0;
    return elt;
}

// Question 3

uf_elt* trouver(uf_elt* elem){
    if(elem->parent == NULL){
        return elem;
    }
    else {
        uf_elt* rep = trouver(elem->parent);
        elem->parent = rep;
        return elem;
    }
}

// Question 4 

void unir(uf_elt* x, uf_elt* y){
    uf_elt* xbis = trouver(x);
    uf_elt* ybis = trouver(y);
    if(xbis->rang > ybis->rang){
        ybis->parent = xbis;
    }
    else {
        xbis->parent = ybis;
        if(xbis->rang == ybis->rang){
            ybis->rang = ybis->rang +1;
        }
    }
}

// II - Tri des arêtes
// Question 5



int main(void){
    
    return 0;
}