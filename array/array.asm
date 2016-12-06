%include "../inc/asm_io.inc"


section .data
a1      dd      1, 2, 3, 4, 5   ;array of 5 double words initialized
a2      times 10 dw 0           ; 10 words initialized
a3      times 10 db 0
        times 10 db 1           ; 10 * 0 + 10 * 1, bytes


section .bss
a4      resd 10                 ; declare array of 10 unitialized dwords


section	.text
    global      main          ; standalone main

main:
    xor         eax, eax
    mov         eax, 1
    dump_regs   1
    test        eax, eax        ;test does bitwise AND and set flags

    ;; show debug info
    dump_regs   1

exit:
    ;; exit
    mov         ebx, 0          ; exit code
    mov         eax, 1          ; invoke
    int         0x80
