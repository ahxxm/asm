%include "../inc/asm_io.inc"


section	.text
    global asm_copy, asm_find, asm_strlen, asm_strcpy


;;; void asm_copy(void *dest, const void *src, unsigned sz);
;;; copies blocks of memory
%define dest [ebp+8]
%define src  [ebp+12]
%define sz   [ebp+16]

asm_copy:
    enter       0, 0
    push        esi
    push        edi

    mov         esi, src        ; address of [being copied from]
    mov         edi, dest       ;
    mov         ecx, sz

    ;; cld: clear direction, string process from low to high, auto-increment mode
    ;; std: set direction flag, vice versa
    cld                         ; Clear direction
    rep         movsb           ; execute MOVSB ECX times

    pop         edi
    pop         esi
    leave
    ret


;;; void *asm_find(const void *src, char target, unsigned sz);
;;; params src: pointer to buffer for search, target: byte value, sz: size of buffer
;;; returns pointer to first occurrence or NULL
;;; "b" for
%define bsrc     [ebp+8]
%define btarget  [ebp+12]
%define bsz      [ebp+12]

asm_find:
    enter       0, 0
    push        edi

    mov         eax, btarget
    mov         edi, bsrc
    mov         ecx, bsz

    cld
    repne       scasb           ; scan until ECX == 0 or [ES:EDI] == AL

    je          asm_found
    mov         eax, 0
    jmp         short asm_not_found
asm_found:
    mov         eax, edi
    dec         eax             ; return (DI-1)
asm_not_found:
    pop         edi
    leave
    ret


;;; unsigned asm_strlen(const char*);
;;; returns number of char in string EAX
%define csrc [ebp+8]
asm_strlen:
    enter       0, 0
    push        edi

    mov         edi, csrc        ; edi = pointer to string
    mov         ecx, 0FFFFFFFFh  ; largest possible ECX
    xor         al, al


    cld
    repnz       scasb           ; scan for terminating 0

    ;; repnz will go one step far
    ;; len = FFFFFFFE - ECX
    mov         eax, 0FFFFFFFEh
    sub         eax, ecx

    pop         edi
    leave
    ret


;;; void asm_strcpy(char *dst, const char *src);
%define ddst [ebp+8]
%define dsrc [ebp+12]
asm_strcpy:
    enter       0, 0
    push        esi
    push        edi

    mov         edi, ddst
    mov         esi, dsrc
    cld
cpy_loop:
    lodsb                       ; load AL & inc SI
    stosb                       ; store AL & inc DI
    or          al, al          ; set condition flags?
    jnz         cpy_loop        ; copy another if not pst terminating 0

    ;; copy ends
    pop         edi
    pop         esi
    leave
    ret
