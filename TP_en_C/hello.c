#include <stdio.h>

int longeur(char* chaine){
    int n = 0;
    while(chaine[n] != '\0'){
        n=n+1;
    }
    return n;
}

int occurencebis(char* mot, char* chaine, int i){
    while(mot[i] != '\0'){
        if(mot[i] == chaine[i]){
            i = i + 1;
        }else{
            return 0;
        }
    }
    return 1;
}

int main(){
    printf("Hello world\n");
    int x = longeur("Hello world");
    printf("%d\n",x);
    int y = occurencebis("world","Hello world",5);
    printf("%d\n",y);
    return 0;
}