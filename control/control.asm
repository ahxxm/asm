%include "../inc/asm_io.inc"


section	.text
    global      main          ; standalone main

main:
loop:   
    ;; Loop
    ;; sum 1 to 10 to eax
    xor         eax, eax
    mov         ecx, 10
loop_sum:   
    add         eax, ecx
    loop        loop_sum      ; loop decreases ecx until 0
after_sum:
    ;; eax == 0x37, 55
    dump_regs   1


ifelse:
    ;; if(a){b;} else{c;}
    ;; translated:
    ;; CMP a
    ;; JXX c
    ;; b
    ;; c
    
cmp:    
    ;; CMP
    ;; r = eax - ebx is computed
    ;; flags are set accordingly
    ;; - r == 0: ZF(zero flag) set
    ;; - r >  0: ZF unset, CF unset(no borrow)
    ;; - r <  0: ZF unset, CF set(borrow)
    ;; CF used as borrow flag for subtraction

    ;; For signed int these 3 are important:
    ;; ZF, OF(overflow flag), SF(sign flag)
    ;; - r >  0: ZF unset, SF=OF
    ;; - r <  0: ZF unset, SF!=OF
    ;; cmp results are stored in FLAGS
    xor         eax, eax
    xor         ebx, ebx

    ;; so after CMP, CF should be set
    ;; mov         eax, 2
    ;; mov         ebx, 3
    ;; dump_regs   1
    ;; cmp         eax, ebx
    ;; jc          exit0           ; jump when CF set
    ;; mov         ebx, 1          ; will never reach here
    ;; mov         eax, 1
    ;; int         0x80


exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80

