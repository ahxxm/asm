all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf memory.asm
	gcc -m32 -o mem.out memory.o main.c ../inc/asm_io.o

test:
	echo "est\nyay" | ./mem.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o
