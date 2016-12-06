driver:
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -f elf array.asm
	gcc -m32 -o arr.out array.o ../inc/asm_io.o

	nasm -f elf arr1.asm
	gcc -m32 arr1.o arr.c -o arr1.out

clean:
	rm *.o *.out
	rm ../inc/asm_io.o

test:
	./arr.out
	echo "10" | ./arr1.out
