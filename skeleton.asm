%include "inc/asm_io.inc"

;; standalone asm skeleton
;; see driver/Makefile for compile and link instructions


section	.text
    global      main          ; standalone main

main:

    ;; show debug info
    dump_regs   1

    ;; exit
    mov         ebx, 0          ; exit code
    mov         eax, 1          ; invoke
    int         0x80
