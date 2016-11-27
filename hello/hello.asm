    ;; Usage:
    ;;   nasm -f elf hello.asm
    ;;   ld -m elf_i386 -s -o hello.out hello.o
    ;; http://www.linuxquestions.org/questions/programming-9/assembly-error-i386-architecture-incompatible-with-i386-x86-64-output-827609/


section	.text
    global _start			;must be declared for linker (ld)

_start:					;tell linker entry point

	xor	ebx,ebx 	;ebx=0
	mov	ecx,msg		;address of message to write
	lea	edx,[ebx+len]	;message length
	lea	eax,[ebx+4]	;system call number (sys_write)
	inc	ebx		;file descriptor (stdout)
	int	0x80		;call kernel

	xor	eax, eax	;set eax=0
	inc	eax		;system call number (sys_exit)
	int	0x80		;call kernel

section	.rodata

msg	db	'Hello, world!',0xa	;our string
len	equ	$ - msg			;length of our string
