%include "../inc/asm_io.inc"


section	.text
    global      calc_sum

calc_sum:
    ;; sum at [ebp-4]
    ;; sum from 1 to N
    enter       4, 0            ; reserve for room on stack
    push        ebx

    mov         dword [ebp-4], 0 ; clean sum
    dump_stack  1, 2, 4          ; print from ebp-8 to ebp+16
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

    pop         ebx             ; restore ebx
    leave
    ret
