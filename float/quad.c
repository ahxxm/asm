#include <stdio.h>

// ax^2+bx+c = 0
// input: a b c, address of solution
// output: solution x1 and x2

int quadratic(double, double, double, double *, double *);

int main(void) {
  double a, b, c, root1, root2;

  printf("Enter a, b, c: ");
  scanf("%lf %lf %lf", &a, &b, &c);

  if(quadratic(a, b, c, &root1, &root2)) {
    printf("Roots are: %.10g %.10g\n", root1, root2);
  } else {
    printf("roots not found.\n");
  }

  return 0;
}
