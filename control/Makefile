all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf control.asm
	gcc -m32 -o control.out control.o ../inc/asm_io.o

test:
	./control.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
