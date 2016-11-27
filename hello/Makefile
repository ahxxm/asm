all:
	nasm -f elf hello.asm
	ld -m elf_i386 -s -o hello.out hello.o

test:
	./hello.out

clean:
	rm hello.o hello.out
