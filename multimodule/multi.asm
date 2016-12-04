%include "../inc/asm_io.inc"


;;; main.asm that calls sum

section .data
sum         dd      0

section .bss
input       resd    1


section	.text
    global      main          ; standalone main
    extern      print_sum, get_int

main:
    mov         edx, 1          ; i = 0
while:
    push        edx
    push        dword input
    call        get_int
    add         esp, 8          ;remove i and &input from stack

    mov         eax, [input]
    cmp         eax, 0
    je          end_while

    add         [sum], eax

    inc         edx
    jmp         short while


end_while:
    push        dword [sum]
    call        print_sum
    pop         ecx             ; remove sum from stack


exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80
