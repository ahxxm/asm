driver:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf bit.asm
	gcc -m32 -o bit.out bit.o ../inc/asm_io.o
	gcc -o endian.out endian.c

clean:
	rm *.o *.out
	rm ../inc/asm_io.o

test:
	./bit.out
	./endian.out
