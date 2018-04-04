; Filename:	polymorph_2.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o polymorph_2.o polymorph_2.nasm
; Link:		ld -o polymorph_2 polymorph_2.o

global _start

section .text
_start:

; original instructions:
;	xor  ebx, ebx
;	mul  ebx
;	push ebx
;	push 0xa216572
;	push 0x6f63206f
;	push 0x6c6c6548
;	mov  dl, 0xc

;	inc  ebx
;	mov  ecx, esp
;	mov  al, 0x4
;	int  0x80

;	xor  eax, eax
;	inc  eax
;	mov  eax, ebx
;	int  0x80


; polymorphed instructions:
	xor  ebx, ebx
	mul  ebx
        push 0xa216572
        push 0x6f63206f
        push 0x6c6c6548
        mov  dl, 0xc

        inc  ebx
        mov  ecx, esp
        mov  al, 0x4
        int  0x80

        mov  al, bl
        int  0x80
