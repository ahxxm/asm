#include <stdio.h>

void calc_sum(int, int *) __attribute__((cdecl));
int sum_int(int) __attribute__((cdecl));


int main(void) {
  int n, sum;

  printf("Sum ints up to: ");
  scanf("%d", &n);
  calc_sum(n, &sum);
  printf("Sum is %d\n", sum);

  int k = sum_int(n);
  printf("Directly calculate %d\n", k);
  return 0;
}
