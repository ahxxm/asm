%include "inc/asm_io.inc"


segment .data

segment	.text
    global      _asm_main		; only windows adds "_" prefix

_asm_main:

    enter       0, 0
    pusha

    ;; code here
    ;; code here

    popa
    mov         eax, 0
    leave
    ret
