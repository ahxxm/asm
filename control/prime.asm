%include "../inc/asm_io.inc"


;;; find prime under Limit
;;; while (guess<=limit){
;;;   factor = 3;
;;;   while (factor^2 < guess and guess % factor!= 0 ){
;;;     factor += 2;
;;;   }
;;;   if guess % factor != 0:
;;;     print(guess);
;;; }
    

segment .data
    Message         db      "Find primes up to: ", 0 ; null terminated?
    
segment .bss    
    Limit       resd    1
    Guess       resd    1

    
section	.text
    global      main          ; standalone main

main:
    enter       0, 0
    pusha

    mov         eax, Message
    call        print_string
    dump_regs   1

    ;; read N
    ;; call        read_int        ;scanf
    mov         eax, 100        ; mov instead
    mov         [Limit], eax

    ;; print first 2 primes
    mov         eax, 2
    call        print_int
    call        print_nl
    mov         eax, 3
    call        print_int
    call        print_nl

    mov         dword [Guess], 5
    
while_limit:                    ; while Guess <= Limit
    mov         eax, [Guess]    ; Guess = 5
    cmp         eax, [Limit]    
    jnbe        exit            ; unsigned, CF==0 and ZF==0
    mov         ebx, 3          ; factor==3

while_factor:
    mov         eax, ebx
    mul         eax             ; eax*=eax
    jo          end_while_factor ;jump if overflow
    cmp         eax, [Guess]
    jnb         end_while_factor ; jump if guess^2 >= limit
    mov         eax, [Guess]
    mov         edx, 0

    ;; w/dw/qw  /  b/w/dw
    ;; al/ax/eax = quotient, ah/dx/edx = remainder
    ;; edx:eax(32+32bits)
    div         ebx             ;edx = edx:eax % ebx
    
    cmp         edx, 0
    je          end_while_factor ;if guess % factor == 0

    add         ebx, 2          ; factor+=2
    jmp         while_factor            

end_while_factor:
    je          end_if          ; if guess % factor == 0
    mov         eax, [Guess]
    call        print_int
    call        print_nl

end_if:
    add         dword [Guess], 2 ; guess+=2
    jmp         while_limit

exit:
    mov         ebx, 0
    mov         eax, 1
    int         0x80

