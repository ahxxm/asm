%include "../inc/asm_io.inc"


section	.text
    global      main          ; standalone main

main:
    xor         eax, eax
    mov         eax, 1
    dump_regs   1
    test        eax, eax        ;test does bitwise AND and set flags

    ;; show debug info
    dump_regs   1

    ;; exit
    mov         ebx, 0          ; exit code
    mov         eax, 1          ; invoke
    int         0x80
