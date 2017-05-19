all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf quad.asm
	gcc -m32 -o quad.out quad.o quad.c ../inc/asm_io.o

	nasm -w+all -f elf prime.asm
	gcc -m32 -o prime.out prime.o prime.c ../inc/asm_io.o

test:
	echo "1 0 -2" | ./quad.out
	./prime.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
