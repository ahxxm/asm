%include "../inc/asm_io.inc"

%define         a       qword [ebp+8]
%define         b       qword [ebp+16]
%define         c       qword [ebp+24]
%define         root1   dword [ebp+32]
%define         root2   dword [ebp+36]
%define         disc    qword [ebp-8]

%define         one_over_2a qword [ebp-16]

section .data
MinusFour       dw      -4


section	.text
    global      quadratic
quadratic:
    push        ebp
    mov         ebp, esp
    sub         esp, 16         ; disc and one_over_2a
    push        ebx             ; save

    ;;;                            stack
    fild        word [MinusFour] ; -4
    fld         a                ; a, -4
    fld         c                ; c, a, -4
    fmulp       st1              ; a*c, -4
    fmulp       st1              ; -4*a*c

    fld         b
    fld         b               ; b, b, -4ac
    fmulp       st1             ; b*b, -4ac
    faddp       st1             ;
    ftst                        ; test with 0
    fstsw       ax
    sahf

    jb          no_real         ; disc < 0, complex solution
    fsqrt                       ; sqrt(b^2-4ac)
    fstp        disc            ; store and pop stack

    fld1                        ; stack: 1.0
    fld         a               ; a, 1.0
    fscale                      ; a*2^(1.0) = 2a, 1
    fdivp       st1             ; 1/(2a)
    fst         one_over_2a     ; 1/(2a)
    fld         b               ; b, 1/(2a)
    fld         disc            ; disc, b, (1/2a)
    fsubrp      st1             ; disc-b, (1/2a)
    fmulp       st1             ; (-b+disc)/(2a)
    mov         ebx, root1

    fstp        qword [ebx]     ; store in *root1
    fld         b               ; stack: b
    fld         disc            ; disc, b
    fchs                        ; -disc, b
    fsubrp      st1             ; -disc-b
    fmul        one_over_2a     ; -(b+disc)/(2a)
    mov         ebx, root2
    fstp        qword [ebx]
    mov         eax, 1          ; return 1
    jmp         short quit

no_real:
    mov         eax, 0

quit:
    pop         ebx
    mov         esp, ebp
    pop         ebp
    ret
