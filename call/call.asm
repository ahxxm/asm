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

call_ret:   
    ;; CALL: push next instruction to stack, then unconditional jump
    ;; RET: pop top of the stack and jump to it
    call        sample_call

    ;; convention: subroutine that are reentrant->safe to call at anywhere
    
    ;; params are not popped off, instead they are accessed from stack
    ;; pass address to change params

    ;; low              stack    high
    ;; subroutine data  esp      params

    ;; push params:
    ;; void fun(int a, int b, int c){}

    
ebp_convention_text:
    ;; EBP: base pointer, reference data on the stack.
    ;; - save value of EBP on the stack
    ;; - set EBP to equal to ESP
    ;; this way ESP can be changed, and restore EBP to ESP when subroutine ends
    call       ebp_convention

param_convention:
    ;; in C it's callee to keep stack consistent,
    ;; because function params may vary
    push       dword 1          ; pass 1 as param
    call       ebp_convention
    add        esp, 4           ; remove param from stack
    
exit0:
    ;; exit
    mov         ebx, 0
    mov         eax, 1
    int         0x80


sample_call:
    call print_nl
    ret

ebp_convention: 
    push        ebp             ; save origin ebp
    mov         ebp, esp
    ;; something here
    pop         ebp
    ret
    
