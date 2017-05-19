all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf call.asm
	gcc -m32 -o call.out call.o ../inc/asm_io.o

test:
	./call.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
