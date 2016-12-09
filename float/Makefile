all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf quad.asm
	gcc -m32 -o quad.out quad.o quad.c ../inc/asm_io.o

test:
	echo "1 4 4" | ./quad.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
