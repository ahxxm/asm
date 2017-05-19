driver: driver.c first.asm ../inc/asm_io.asm
	nasm -f elf -d ELF_TYPE ../inc/asm_io.asm
	nasm -w+all -f elf first.asm
	gcc -m32 -o first.out driver.c first.o ../inc/asm_io.o

clean:
	rm *.o *.out
	rm ../inc/asm_io.o

all: driver

test:
	echo "1 2" | ./first.out
