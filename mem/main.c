#include <stdio.h>

#define STR_SIZE 30

void asm_copy(void *, const void *, unsigned) __attribute__((cdecl));
void *asm_find(const void *,
               char target,
               unsigned) __attribute__((cdecl));
unsigned asm_strlen(const char *) __attribute__((cdecl));
void asm_strcpy(char *, const char *) __attribute__((cdecl));


int main(void) {
  char st1[STR_SIZE] = "test string";
  char st2[STR_SIZE];
  char *st;
  char ch;

  asm_copy(st2, st1, STR_SIZE);
  printf("Copied to st2: %s\n", st2);

  printf("Enter a char: "); // looking for this byte in string
  scanf("%c%*[^\n]", &ch); // FIXME: strip?
  st = asm_find(st2, ch, STR_SIZE);

  if(st) {
    printf("Found it: %s\n", st);
  } else {
    printf("Not found\n");
  }

  st1[0] = 0;
  printf("Enter string: ");
  scanf("%s", st1); // input another string and show its size
  printf("Length of new st1 is %u \n", asm_strlen(st1));

  asm_strcpy(st2, st1); // copy until 0 from st1 to st2
  printf("%s\n", st2);

  return 0;

}
