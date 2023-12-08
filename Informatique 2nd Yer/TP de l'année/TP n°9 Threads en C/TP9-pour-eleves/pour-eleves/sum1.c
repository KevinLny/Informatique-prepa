#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <math.h>

#include "clock.h"

double SUM = 0.;
pthread_mutex_t LOCK;


struct thread_args {
    float *arr;
    int len;
};

typedef struct thread_args thread_args;


//
void *partial_sum(void *fun_args);


double *create_array(int len){
    double *arr = malloc(len * sizeof(double));
    for (int i = 0; i < len; i++) {
        arr[i] = sin(i);
    }
    return arr;
}


int main(int argc, char *argv[]){
    return 0;
}
