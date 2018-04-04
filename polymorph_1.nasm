; Filename:	polymorph_1.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o polymorph_1.o polymorph_1.nasm
; Link:		ld -o polymorph_1 polymorph_1.o

global _start

section .text
_start:

; original instructions:
;	xor eax, eax
;	mov al, 0x1
;	xor ebx, ebx
;	int 0x80

; polymorphed instructions:
	push byte 0x1
	pop eax
	xor ebx, ebx
	int 0x80
