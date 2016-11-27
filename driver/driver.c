/*
  Under 64bit linux, install gcc-multilib and:
  nasm -f elf first.asm
  gcc -m32 -o first.out first.o driver.c ../inc/asm_io.o

  in which `asm_io.o`:
  nasm -f elf -d ELF_TYPE asm_io.asm

 */

extern int asm_main();

int main() {
  // - C lets compiled program run in protected mode
  // - C libraries available for asm code
  int ret = asm_main();
  return ret;
}
