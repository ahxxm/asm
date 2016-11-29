%include "../inc/asm_io.inc"


section	.text
    global      main          ; standalone main

main:
    ;; cmp results are stored in FLAGS
    xor         eax, eax
    xor         ebx, ebx
    mov         eax, 2
    mov         ebx, 3

    cmp         eax, ebx
    dump_regs   1

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

    ;; so after CMP, CF should be set
    jc          exit0           ; jump when CF set
    mov         ebx, 1          ; will never reach here
    mov         eax, 1
    int         0x80

exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80
