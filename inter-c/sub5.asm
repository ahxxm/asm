%include "../inc/asm_io.inc"


section	.text
    global      calc_sum, sum_int

calc_sum:
    ;; sum at [ebp-4]
    ;; sum from 1 to N
    ;; store to int
    enter       4, 0            ; reserve for room on stack
    push        ebx             ; important: convention requires EBX unmodified

    mov         dword [ebp-4], 0 ; clean sum

    ;; print from ebp-8 to ebp+16.
    ;; 1: label
    ;; 2, 4: how many dword to display, below and above EBP respectively
    dump_stack  1, 2, 4

    mov         ecx, 1           ; i

loop:
    cmp         ecx, [ebp+8]    ; i and n
    jnle        end_for

    add         [ebp-4], ecx    ; sum+=i
    inc         ecx
    jmp         short loop


end_for:
    mov         ebx, [ebp+12]   ; ebx = sump
    mov         eax, [ebp-4]    ; eax = sum
    mov         [ebx], eax      ; *ebx = eax
    dump_stack  1, 2, 4

    pop         ebx             ; restore ebx
    leave
    ret


sum_int:
    ;; sum to N and store to eax
    enter       4, 0
    push        ebx
    mov         dword [ebp-4], 0 ; clean sum
    mov         ecx, 1
    dump_stack  1, 2, 3
sum_loop:
    ;; because grows from high to low
    ;; ebp+12: param2(exists above)
    ;; ebp+8: param 1
    ;; ebp: return address
    ;; ebp-4: local vars
    cmp         ecx, [ebp+8]
    jnle        sum_end
    add         [ebp-4], ecx
    inc         ecx
    jmp         short sum_loop
sum_end:
    mov         eax, [ebp-4]
    dump_stack  1, 2, 3

    pop         ebx
    leave
    ret
