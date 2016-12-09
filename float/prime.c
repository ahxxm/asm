#include <stdio.h>
#include <stdlib.h>


/* efficient implementation:
   store primes,
   use only found-primes to divide,
   calculate sqrt of the guess,
*/

// array a, n primes to be found
extern void find_primes(int *arr, unsigned n);

int main(void) {
  unsigned i;
  unsigned n = 5;
  int *a;

  // printf("How many primes to be found?");
  // scanf("%u", &n);
  a = calloc(sizeof(int), n);


  // find and print last 20
  // FIXME: not working
  find_primes(a, n);
  for(i = (n > 20) ? n - 20 : 0; i < n; i++) {
    printf("Prime No.%3d: [%d]\n", i+1, a[i]);
  }
  free(a);
  return 0;
}
