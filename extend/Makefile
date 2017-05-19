all:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf extend.asm
	gcc -m32 -o extend.out extend.o ../inc/asm_io.o

test:
	./extend.out

clean:
	rm extend.o extend.out
	rm ../inc/asm_io.o
