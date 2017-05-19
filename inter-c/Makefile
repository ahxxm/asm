all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf sub5.asm
	gcc -m32 -o c.out sub5.o main.c ../inc/asm_io.o

test:
	echo "55" | ./c.out

clean:
	rm sub5.o c.out
	rm ../inc/asm_io.o
