#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/* ============== Quelques fonctions utilitaires ================= */

void copier_tableau(int t[], int deb, int fin, int copie[]) {
    // Copie la tranche de tableau t[deb:fin] dans copie (qui est un tableau de
    // taille fin - deb)
    for (int k = 0; k < fin - deb; k++) {
        copie[k] = t[deb + k];
    }
    return;
}

int* genere_tableau_aleatoire(int n) {
    int* t = malloc(sizeof(int) * n);
    for (int i = 0; i < n; i++) {
        t[i] = rand();
    }
    return t;
}

bool est_trie(int* t, int n) {
    for (int i = 0; i < n - 1; i++) {
        if (t[i] > t[i + 1]) {
            return false;
        }
    }
    return true;
}

// Échange les cases i et j dans le tableau t
void swap(int* t, int i, int j) {
    int temp = t[i];
    t[i] = t[j];
    t[j] = temp;
}

// Trie le tableau t dans la tranche t[deb : fin]
// O( (fin - deb)^2 )
void tri_insertion(int* t, int deb, int fin) {
    for (int j = deb + 1; j < fin; j++) {
        int cle = t[j];
        int i = j - 1;
        while ((i >= deb) && (t[i] > cle)) {
            t[i + 1] = t[i];
            i--;
        }
        t[i + 1] = cle;
    }
}

void affiche_tableau(int arr[], int deb, int fin) {
    printf("deb = %d, fin = %d :\n  [ ", deb, fin);
    for (int i = deb; i < fin; i++) {
        printf("%d ", arr[i]);
    }
    printf("]\n");
}

/* Début de l'exercice 1 */

/* Cette fonction va scanner le tableau de gauche à droite : à chaque fois que
 * l'on trouve un t[i] <= pivot, il suffit d'incrémenter i pour garder
 * l'invariant et à chaque fois que l'on trouve un t[i] strictement supérieur au
 * pivot, on le met à droite et on décrémente j. Comme on ne sait pas si
 * l'élément avec lequel on échange t[i] se compare au pivot, on n'incrémente
 * pas i dans ce cas. */

int partitionner_hoare_naif(int* t, int deb, int fin) {
    int pivot = t[deb];
    int i = deb + 1;
    int j = fin - 1;
    // T[deb+1:i] <= pivot, T[j+1:fin] > pivot
    while (i <= j) {
        if (t[i] > pivot) {
            swap(t, i, j);
            j--;
        } else {
            i++;
        }
    }
    swap(t, deb, i - 1);
    return i - 1;
}

/* La fonction suivante vise à implémenter un peu différemment le partitionnement de Hoare : au lieu de faire un échange dès qu'on trouve un t[i] > pivot, on veut ne faire un échange que si t[i] > pivot et t[j] <= pivot. Ainsi, on augmente i tant que t[i] <= pivot, on diminue j tant que t[j] > pivot, et seulement là on fait l'échange. */

int partitionner_hoare(int* t, int deb, int fin) {
    assert(fin - deb > 1);
    int pivot = t[deb];
    int i = deb + 1;
    int j = fin - 1;
    // L'invariant respecté par cette boucle est : T[deb+1 : i] <= pivot, T[j+1 : fin] > pivot.
    while (true) {
        while (i < fin && t[i] <= pivot) {
            i++;
        }
        while (t[j] > pivot) {
            j--;
        }
        if (i < j) {
            swap(t, i, j);
            i++;
            j--;
        } else {
            swap(t, deb, j);
            return j;
        }
    }
}

void tri_rapide_aux(int* t, int deb, int fin) {
    if (fin - deb > 1) {
        int pos_pivot = partitionner_hoare_naif(t, deb, fin);

        // On prend le pivot choisi pour partitionner initialement au début de
        // la tranche.

        tri_rapide_aux(t, deb, pos_pivot);
        tri_rapide_aux(t, pos_pivot + 1, fin);
    }
}

void tri_rapide(int* t, int n) { tri_rapide_aux(t, 0, n); }

/* ============== Exercice 2 ================= */

// On rappelle le tri fusion codé dans le TP précédent

void fusion(int t[], int deb, int mil, int fin) {
    int* t1 = malloc(sizeof(int) * (mil - deb));
    int* t2 = malloc(sizeof(int) * (fin - mil));
    copier_tableau(t, deb, mil, t1);
    copier_tableau(t, mil, fin, t2);

    // On a copié les deux tranches triées dans t1 et t2 : maintenant, on va les
    // fusionner dans t[deb:fin].
    int i1 = 0;
    int i2 = 0;
    int j = deb;

    // On fusionne les deux tableaux jusqu'à arriver à la fin de l'un des deux
    // tableaux
    while (i1 < mil - deb && i2 < fin - mil) {
        if (t1[i1] <= t2[i2]) {
            t[j] = t1[i1];
            i1++;
        } else {
            t[j] = t2[i2];
            i2++;
        }
        j++;
    }

    // On finit la fusion avec ce qui reste de t1 ou de t2
    while (i1 < mil - deb) {
        t[j] = t1[i1];
        i1++;
        j++;
    }
    while (i2 < fin - mil) {
        t[j] = t2[i2];
        i2++;
        j++;
    }

    free(t1);
    free(t2);
}

void tri_fusion_aux(int t[], int deb, int fin) {
    if (deb < fin - 1) {
        int mil = (deb + fin) / 2;

        tri_fusion_aux(t, deb, mil);
        tri_fusion_aux(t, mil, fin);
        fusion(t, deb, mil, fin);
    }
}

void tri_fusion(int t[], int n) { tri_fusion_aux(t, 0, n); }

// Cette fonction partitionne le tableau en utilisant le schéma de Hoare, mais en choisissant le pivot aléatoirement et en le swapant avec l'élément d'indice deb.

int partitionner_hoare_random(int* t, int deb, int fin) {
    int choix_pivot = deb + (abs(rand()) % (fin - deb));
    assert(deb <= choix_pivot && choix_pivot < fin);
    swap(t, deb, choix_pivot);
    return partitionner_hoare(t, deb, fin);
}

void tri_rapide_random_aux(int* t, int deb, int fin) {
    if (fin - deb > 1) {
        int pos_pivot = partitionner_hoare_random(t, deb, fin);

        // On prend le pivot choisi pour partitionner initialement au début de
        // la tranche.

        tri_rapide_random_aux(t, deb, pos_pivot);
        tri_rapide_random_aux(t, pos_pivot + 1, fin);
    }
}

void tri_rapide_random(int* t, int n) { tri_rapide_random_aux(t, 0, n); }

void test_temps_execution_aleatoire(int n) {
    int* t = genere_tableau_aleatoire(n);

    int* t1 = malloc(sizeof(int) * n);
    int* t2 = malloc(sizeof(int) * n);
    int* t3 = malloc(sizeof(int) * n);
    copier_tableau(t, 0, n, t1);
    copier_tableau(t, 0, n, t2);
    copier_tableau(t, 0, n, t3);

    clock_t c0 = clock();
    tri_insertion(t, 0, n);
    clock_t c1 = clock();
    tri_fusion(t1, n);
    clock_t c2 = clock();
    tri_rapide(t2, n);
    clock_t c3 = clock();
    tri_rapide_random(t3, n);
    clock_t c4 = clock();

    assert(est_trie(t, n));
    assert(est_trie(t1, n));
    assert(est_trie(t2, n));
    assert(est_trie(t3, n));

    // Ici, les 1.0 * ... servent juste à forcer les opérations à se faire entre flottants : 1.0 est un flottant, donc 1.0 * (c1 - c0) converti l'entier de droite en un flottant, donc la division se fait aussi entre flottants.
    double temps_insertion = 1.0 * (c1 - c0) / CLOCKS_PER_SEC;
    double temps_fusion = 1.0 * (c2 - c1) / CLOCKS_PER_SEC;
    double temps_rapide = 1.0 * (c3 - c2) / CLOCKS_PER_SEC;
    double temps_rapide_random = 1.0 * (c4 - c3) / CLOCKS_PER_SEC;
    printf("Pour un tableau aléatoire de taille %d :\n", n);
    printf("    Tri insertion : %.3f s\n", temps_insertion);
    printf("    Tri fusion : %.3f s\n", temps_fusion);
    printf("    Tri rapide : %.3f s\n", temps_rapide);
    printf("    Tri rapide randomisé : %.3f s\n", temps_rapide_random);

    free(t);
    free(t1);
    free(t2);
    free(t3);
}

void test_temps_execution_trie_croissant(int n) {
    int* t = malloc(sizeof(int) * n);
    for (int k = 0; k < n; k++) {
        t[k] = k;
    }

    int* t1 = malloc(sizeof(int) * n);
    int* t2 = malloc(sizeof(int) * n);
    int* t3 = malloc(sizeof(int) * n);
    copier_tableau(t, 0, n, t1);
    copier_tableau(t, 0, n, t2);
    copier_tableau(t, 0, n, t3);

    clock_t c0 = clock();
    tri_insertion(t, 0, n);
    clock_t c1 = clock();
    tri_fusion(t1, n);
    clock_t c2 = clock();
    tri_rapide(t2, n);
    clock_t c3 = clock();
    tri_rapide_random(t3, n);
    clock_t c4 = clock();

    assert(est_trie(t, n));
    assert(est_trie(t1, n));
    assert(est_trie(t2, n));
    assert(est_trie(t3, n));

    double temps_insertion = 1.0 * (c1 - c0) / CLOCKS_PER_SEC;
    double temps_fusion = 1.0 * (c2 - c1) / CLOCKS_PER_SEC;
    double temps_rapide = 1.0 * (c3 - c2) / CLOCKS_PER_SEC;
    double temps_rapide_random = 1.0 * (c4 - c3) / CLOCKS_PER_SEC;
    printf("Pour un tableau trié de taille %d :\n", n);
    printf("    Tri insertion : %.3f s\n", temps_insertion);
    printf("    Tri fusion : %.3f s\n", temps_fusion);
    printf("    Tri rapide : %.3f s\n", temps_rapide);
    printf("    Tri rapide randomisé : %.3f s\n", temps_rapide_random);

    free(t);
    free(t1);
    free(t2);
    free(t3);
}

int main(int argc, char* argv[]) {
    // int main() {
    srand(time(NULL));
    // int t[] = {5, 3, 2, 15, 6, 7, 9, 4, 8};
    // tri_rapide(t, 9);
    // affiche_tableau(t, 0, 9);

    int n;
    if (argc < 2) {
        n = 1000;
    } else {
        n = atoi(argv[1]);
    }
    test_temps_execution_aleatoire(n);
    test_temps_execution_trie_croissant(n);
}