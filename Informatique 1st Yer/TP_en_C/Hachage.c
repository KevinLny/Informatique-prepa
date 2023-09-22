#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

// Implementation des listes et couples necessaire pour l'implémentation table hash

//Alveole

struct alveole{
    int cle;
    char* valeur;
    struct alveole* queue;
};

typedef struct alveole liste;

// Fonction de Hash pris sur un forum random
unsigned int HashCode (char  *ligne){
   unsigned int Code = 0;
   size_t const len = strlen (ligne);
   size_t i; 
 //  printf ("ligne = '%s'\n", ligne);
    for (i = 0; i < len; i++){
      Code = ligne[i] + 31 * Code;
   }
   return Code % 101;
}

// Table de Hachage
liste* TableaubHash[101];

void ajouter_valeur(char* mot){
    TableaubHash[HashCode(mot)]->cle = HashCode(mot);
    TableaubHash[HashCode(mot)]->valeur = mot;
}

bool rechercher_val_bis(liste* lst, char* mot){
    if(lst!=NULL){
        if(lst->valeur == mot){
            return true;
        }
        else{
            return rechercher_val_bis(lst->queue, mot);
        }
    }
    return false;
}

bool rechercher_val(char* mot){
    return rechercher_val_bis(TableaubHash[HashCode(mot)],mot);
}

void liberer(liste* lst){
        liberer(lst -> queue);
        free(lst);
}

void tout_liberer(void){
    int n =0;
    while(n != 0){
        liberer(TableaubHash[n]);
    }
}
int main(void){
    ajouter_valeur("Hello");
    printf("%d\n\n",rechercher_val("Hello"));
    tout_liberer();
    return 0;
}
