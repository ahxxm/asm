%include "../inc/asm_io.inc"


section	.text
    global      main          ; standalone main

main:

    xor         eax, eax        ; zero eax
    mov         ah, -1          ; 
    dump_regs   1
    movzx       eax, ah         ; dst: 16/32bit reg. src: 8/16bit reg. this case it's 32 and 16
    ;; 0x[0000]ff[00] becomes 0x[000000]ff, unsigned value(256) keeps

    ;; show debug info
    dump_regs   1
    
    ;; exit
    mov         eax, 1
    int         0x80
