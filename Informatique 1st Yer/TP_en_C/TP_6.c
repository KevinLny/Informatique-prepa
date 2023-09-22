#include <stdio.h>
#include <stdlib.h>
#define bool unsigned int
#define true 1
#define false 0


struct Chainon{
    double tete;
    struct Chainon* queue;
};

typedef struct Chainon liste;

liste* liste_a_un_element(double x){
    liste* p = malloc(sizeof(liste));
    p->tete = x;
    p->queue = NULL;
    return p;
}

liste* cons(double t, liste* q){
    liste* p = liste_a_un_element(t);
    p-> queue = q;
    return p;
}

liste* depuis_tableau(double* tab, int n){
    liste* liste = liste_a_un_element(tab[n]);
    for(int i = n-1; i>0; i--){
        liste = cons(tab[i], liste);
    }
    return liste;
}

int head(liste* lst){
    return lst ->tete;
}

liste* tail(liste* lst){
    return lst ->queue;
}

void liberer(liste* lst){
        liberer(lst -> queue);
        free(lst);
}

void afficher_liste(liste* lst){
    if(lst!=NULL){
        printf("%f, ",lst -> tete);
        afficher_liste(lst -> queue);
    }
    else{
        printf("\n");
    }
}

void f(double x){
    printf("%f,\n",x);
}

void iter_liste(liste* lst){
    if(lst!=NULL){
        f(lst -> tete);
        iter_liste(lst -> queue);
    }   
}

double somme(liste* lst){
    if(lst!=NULL){
        return lst -> tete + somme(lst -> queue);
    }
    return 0.;
}

int longeur(liste* lst){
    if(lst!=NULL){
        return 1 + longeur(lst -> queue);
    }
    return 0;
}

bool sont_egales(liste* l1, liste* l2){
    if(l1 == NULL && l2 == NULL){
        return true;
    }
    if(l1 != NULL || l2 != NULL){
        if(l1 -> tete == l2 -> tete){
            return sont_egales(l1 -> queue, l2 -> queue);
        }
        else{
            return false;
        }
    }
    else{
        return false;
    }
}

bool est_triee(liste* lst){
    if (lst != NULL){
        if(lst -> tete <= (lst -> queue) -> tete){
            if(lst->queue == NULL){
                return true;
            }
            else{
                return est_triee(lst -> queue);
            }
        }
        else{
            return false;
        }
    }
    else{
        return true;
    }
}



// EXERCICE 3


int main(void){
    liste* liste1 = liste_a_un_element(3.0);
    liste* liste2 = cons(2.0, liste1);
    liste* liste3 = cons(1., liste2);
    
    afficher_liste(liste1);
    afficher_liste(liste2);
    afficher_liste(liste3);

    iter_liste(liste3);
    printf("somme : %f\n",somme(liste3));
    printf("longueur : %d\n",longeur(liste3));
    printf("egale : %d\n",sont_egales(liste3,liste2));
    printf("triee : %d\n",est_triee(liste3));
    printf("Hello world\n");
    free(liste1);    
    free(liste2);    
    free(liste3);    
    return 0;
}