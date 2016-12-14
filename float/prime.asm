%include "../inc/asm_io.inc"

section .text
    global find_primes

%define         array   ebp+8
%define         nf      ebp+12  ; n to be find
%define         n       ebp-4
%define         isqrt   ebp-8   ; floor of sqrt(guess)
%define         origcw  ebp-10  ; original control word
%define         newcw   ebp-12  ; new control word
;;; control bits:
;;; both 0(default) - coprocessor rounds when converting to int
;;; both 1 - truncates

find_primes:
    enter       12, 0

    push        ebx
    push        esi

    fstcw       word [origcw]   ; get current control word
    mov         ax, [origcw]
    or          ax, 0C00h       ; set rounding bits to 11(truncate)
    mov         [newcw], ax
    fldcw       word [newcw]

    mov         esi, [array]    ; esi points to array
    mov         dword [esi], 2  ; array[0] = 2, array[1] = 3
    mov         dword [esi+4], 3    ; array[0] = 2, array[1] = 3
    mov         ebx, 5              ; guess start from 5
    mov         dword [n], 2        ; len(array)

while_limit:
    mov         eax, [n]
    cmp         eax, [nf]
    jnb         short quit_limit

    mov         ecx, 1          ; array index
    push        ebx             ; store guess on stack
    fild        dword [esp]     ; load guess onto coprocessor stack
    pop         ebx             ; get guess out of stack
    fsqrt                       ; find sqrt(guess)
    fistp       dword [isqrt]   ; isqrt=floor(sqrt(guess))

while_factor:
    mov         eax, dword [esi + 4*ecx] ; eax = array[ecx]
    cmp         eax, [isqrt]             ; while(isqrt < array[ecx])
    jnbe        short quit_factor_prime

    mov         eax, ebx
    xor         edx, edx
    div         dword [esi + 4*ecx]
    or          edx, edx        ; guess % array[ecx] != 0
    jz          short quit_factor_not_prime

    inc         ecx             ; try next prime
    jmp         short while_factor

;;; found a new one!
quit_factor_prime:
    mov         eax, [n]
    mov         dword [esi+4*eax], ebx ; add guess to end of array
    inc         eax
    mov         [n], eax        ; inc n, len(array)

quit_factor_not_prime:
    add         ebx, 2          ; try next odd number
    jmp         short while_limit

quit_limit:
    fldcw       word [origcw]   ; restore control word
    pop         esi
    pop         ebx

    leave
    ret
