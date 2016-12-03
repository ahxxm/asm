%include "../inc/asm_io.inc"


section	.text
    global      main          ; standalone main

main:
    ;; PUSH: insert dword on stack --
    ;; subtract 4 from ESP
    ;; then store the dw at [ESP]
    push        dword   1       ; 1 at 0FFCh(ESP)
    push        dword   2       ; 2 at 0FF8h
    push        dword   3
    pop         eax             ; 3 2 1
    pop         ebx
    pop         ecx
    dump_regs   1

    ;; PUSHA stores many registers, POPA restore them

exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80

