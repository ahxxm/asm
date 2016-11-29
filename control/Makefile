all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf control.asm
	gcc -m32 -o control.out control.o ../inc/asm_io.o
	nasm -f elf prime.asm
	gcc -m32 -o prime.out prime.o ../inc/asm_io.o

test:
	./control.out
	./prime.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
