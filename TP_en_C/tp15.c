#include <stdio.h>
#include <stdlib.h>

// Exercice 1

// 1) Elle correspondent aux tâches fait en retard 
// 2) 5

// Exercice 2 

// 1) 
// 
//   ti  | 0 | 1 | 2 | 3 | 4 | 5 |
// f(ti) | 1 | 2 | 3 | 4 | 5 | 6 |
// p(ti) | 1 | 1 | 1 | 1 | 1 | 1 |
// d(ti) | 0 | 1 | 2 | 3 | 4 | 5 |

// 2) 
// 
//   ti  | 0 | 1 | 2 | 3 | 4 | 5 |
// f(ti) | 0 | 1 | 2 | 3 | 4 | 4 |
// p(ti) | 1 | 1 | 1 | 1 | 1 | 1 |
// d(ti) | 0 | 1 | 2 | 3 | 4 | 5 |

// Exercice 3

// 1) Le nombre de solution n!

// Exercice 4
// On fait le dm au dernier moment et on prends le plus grands en premier

// Exercice 5

struct tache{
    unsigned int id;
    unsigned int date_limite;
    unsigned int penalite;
    int debut;
};

typedef struct tache tache;

tache creer_tache(unsigned int id, unsigned int date_limite, unsigned int penalite){
    tache tache;
    tache.id = id;
    tache.date_limite = date_limite;
    tache.penalite = penalite;
    tache.debut = -1;
    return tache;
};

qsort(taches, nb_taches, sizeof(tache), compare_taches);

int compare_taches(const void* t1, const void* t2) {
tache* tache1 = (tache*)t1;
tache* tache2 = (tache*)t2;
if(tache1->penalite < tache2->penalite)
    return +1;
if(tache1->penalite > tache2->penalite)
    return  -1;
return 0;
}


int main(void) {
    printf("Hello world\n");
    tache t0 = creer_tache(0, 1, 3);
    tache t1 = creer_tache(1, 2, 6);
    tache t2 = creer_tache(2, 3, 4);
    tache t3 = creer_tache(3, 4, 2);
    tache t4 = creer_tache(4, 4, 5);
    tache t5 = creer_tache(5, 4, 7);
    tache t6 = creer_tache(6, 6, 1);
    tache taches[7] = {t0, t1, t2, t3, t4, t5, t6};
    return 0;
}