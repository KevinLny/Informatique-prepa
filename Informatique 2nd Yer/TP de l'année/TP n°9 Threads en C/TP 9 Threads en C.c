//////////////////////////////////////////////////////////////////
//  Kevin Kuzu                                                  //
//  TP 9 : Threads en C                                         //
//  01/12/2023                                                  //
//////////////////////////////////////////////////////////////////


#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <pthread.h>

// Exercice 1 : Création de Threads

void  *affiche(void *arg){
    int *id = (int*) arg;
    printf("Hello world ! thread : %i\n", *id);
    return NULL;
}

int main(int argc, char* argv[]){
    printf("%s %s\n", argv[0],argv[1]);
    int n = atoi(argv[1]);
    printf("%i\n",n);
    pthread_t thread_id[n];
    int arg[n];
    for(int id = 0; id < n; id++){
        arg[id] = id;
        pthread_create(&thread_id[id], NULL, affiche, &arg[id]);
    }
    for(int id = 0; id < n; id++){
        pthread_join(thread_id[id], NULL);
    }
    return 0;
} 

