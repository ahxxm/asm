%include "../inc/asm_io.inc"

    
section .data
    msg         db      "Calling print subroutine", 0
    
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
    call        print_nl

call_print_ecx: 
    ;; call subroutine, calculate instruction pointer
    ;; 7 is only for short jump
    mov         ecx, $+7        ; later instruction pointer
    jmp         short _print
    call        print_nl


call_print_stack: 
    ;; hardware stack

    
    
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
    mov         eax, 2
    mov         ebx, 3
    dump_regs   1
    call        print_nl
    cmp         eax, ebx
    jc          exit0           ; jump when CF set
    mov         ebx, 1          ; will never reach here
    mov         eax, 1
    int         0x80


exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80

_print:
    ;; subroutine put after the end of main
    ;; ecx is origin instruction pointer
    mov         eax, msg
    call        print_string
    call        print_nl
    jmp         ecx
