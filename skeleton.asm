%include "inc/asm_io.inc"

;; standalone asm skeleton
;; see driver/Makefile for compile and link instructions


section	.text
    global      main          ; standalone main

main:

    ;; show debug info
    dump_regs   1
    
    ;; exit
    mov         eax, 1
    int         0x80
