#include <stdio.h>
int main(void) {
  unsigned short word = 0x1234; // assumes sizeof(short) == 2
  unsigned char *p = (unsigned char *)&word; // points to start of word

  if(p[0] == 0x12) {
    printf("Big endian\n");
  } else {
    printf("Little endian\n");
  }
  return 0;
}
