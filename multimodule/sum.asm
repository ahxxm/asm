%include "../inc/asm_io.inc"

section .data
prompt  db "Enter an integer: ", 0
result  db "The sum is ", 0

section	.text
    global      get_int, print_sum          ; standalone main

get_int:
    enter       0, 0

    mov         eax, [ebp + 12]
    call        print_int

    mov         eax, prompt
    call        print_string
    call        read_int

    mov         ebx, [ebp + 8]
    mov         dword [ebx], eax       ;store (none-existing)input
    leave
    ret


print_sum:
    enter       0, 0

    mov         eax, result
    call        print_string

    mov         eax, [ebp + 8]
    call        print_int
    call        print_nl

    leave
    ret
