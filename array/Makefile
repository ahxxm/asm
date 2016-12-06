driver:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf array.asm
	gcc -m32 -o arr.out array.o ../inc/asm_io.o

clean:
	rm *.o *.out
	rm ../inc/asm_io.o

test:
	./arr.out
