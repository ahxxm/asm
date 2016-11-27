%include "../inc/asm_io.inc"

;;; strings
segment .data
    prompt1 db      "Enter a number: ", 0 ; null terminator
    prompt2 db      "Enter another number: ", 0
    msg1 db         "Entered: ", 0
    msg2 db         " and ", 0
    msg3 db         ", the sum is: ", 0

;;; reserve dword for int input
segment .bss
    input1 resd 1
    input2 resd 1

;;; code
segment .text
    global asm_main
asm_main:
    enter       0, 0
    pusha

    ;; read 2 int
    mov         eax, prompt1
    call        print_string

    call        read_int
    mov         [input1], eax

    mov         eax, prompt2
    call        print_string

    call        read_int
    mov         [input2], eax

    ;; add and store to ebx
    mov         eax, [input1]
    add         eax, [input2]
    mov         ebx, eax

    ;; show debug info
    dump_regs   1
    dump_mem    2, msg1, 1

    ;; print result
    ;; 3 message
    mov         eax, msg1
    call        print_string
    mov         eax, [input1]
    call        print_int
    mov         eax, msg2
    call        print_string
    mov         eax, [input2]
    call        print_int
    mov         eax, msg3
    call        print_string
    ;; sum
    mov         eax, ebx
    call        print_int
    call        print_nl        ; new line

    popa
    mov         eax, 0
    leave
    ret
