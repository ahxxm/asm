%include "../inc/asm_io.inc"

;;; use arr1.c as driver


%define SIZE 100
%define NEW_LINE 10


section .data
FirstMsg        db      "First 10 elements of arr: ", 0
Prompt          db      "Enter index to display: ", 0
SecondMsg       db      "Element %d is %d", NEW_LINE, 0
ThirdMsg        db      "Elements 20 through 29 of array", 0
InputFormat     db      "%d", 0


section .bss
array           resd    SIZE


section	.text
    extern       puts, printf, scanf, dump_line ; from C
    global      asm_main          ; standalone main

asm_main:
    ;;
    enter       4, 0
    push        ebx
    push        esi

    ;; initialize array to 100, 99, 98 ...
    mov         ecx, SIZE
    mov         ebx, array      ; ebx holds array address

loop:
    mov         [ebx], ecx      ; first element
    add         ebx, 4          ; ebx points to 2nd of array
    loop        loop       ; decrease ecx and

    ;; now loop ends
    push        dword FirstMsg
    call        puts
    pop         ecx             ; pop FirstMsg

    push        dword 10
    push        dword array
    call        print_array     ; print_array(&arr, 10);
    add         esp, 8          ; remove 2 args

    ;; prompt user for element index
prompt_loop:
    push        dword Prompt
    call        printf
    pop         ecx

    lea         eax, [ebp-4]    ; eax = &local_dw
    push        eax
    push        dword InputFormat
    call        scanf           ; scanf("%d", eax)
    add         esp, 8          ; remove 2 args

    cmp         eax, 1          ; eax = return value of scanf
    je          Ok              ;

    ;; else dump line and promp again
    call        dump_line
    jmp         prompt_loop

Ok:
    mov         esi, [ebp-4]    ; esi = local_dw??
    push        dword [array + 4 * esi]
    push        esi
    push        SecondMsg       ; print out value of element
    call        printf
    add         esp, 12

    push        dword ThirdMsg  ; print out elements 20-29
    call        puts
    pop         ecx

    push        dword 10
    push        dword array + 20 * 4 ; address of array[20]
    call        print_array
    add         esp, 8

    pop        esi
    pop         ebx
    mov         eax, 0          ; back to C
    leave
    ret

;;; routine print_array
;;; void print_array(const int *a, int n)
;;; prints n element after a

section .data
OutputFormat    db      "%-5d %5d", NEW_LINE, 0


section .text
    global print_array
print_array:
    enter       0, 0
    push        esi
    push        ebx

    xor         esi, esi
    mov         ecx, [ebp+12]   ; ecx = n
    mov         ebx, [ebp+8]    ; ebx = &arr

print_loop:
    push        ecx                   ; store ecx for loop because of call
    push        dword [ebx + 4 * esi] ; arr[esi]'s address
    push        esi
    push        dword OutputFormat
    call        printf
    add         esp, 12

    inc         esi             ; print next
    pop         ecx
    loop        print_loop

    ;; loop ends
    pop         ebx
    pop         esi
    leave
    ret
