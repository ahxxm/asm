all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf multi.asm
	nasm -f elf sum.asm
	gcc -m32 -o multi.out multi.o sum.o ../inc/asm_io.o

test:
	echo "1 2 3 4 0" | ./multi.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
