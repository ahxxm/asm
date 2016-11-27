#include <stdio.h>

/*
  Usage:
  gcc hello.c -S -o hello.S
  gcc -c hello.S -o hello.o
  gcc hello.o -o hello.out
*/

int main(int argc, char** argv){
  printf("Hello World\n");
  return 0;
}
