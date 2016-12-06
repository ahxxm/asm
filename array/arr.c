#include <stdio.h>

int asm_main(void);
void dump_line(void);


void dump_line(void) {
  int ch;
  while((ch = getchar()) != EOF && ch != '\n') {/* null*/ };
}


int main(void) {
  return asm_main();
}
