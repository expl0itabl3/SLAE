#!/usr/bin/env python

import base64


def encrypter(key, string):
    encrypted = []
    for i in range(len(string)):
        key_c = key[i % len(key)]
        encrypted_c = chr(ord(string[i]) + ord(key_c) % 256)
        encrypted.append(encrypted_c)
    encrypted_string = "".join(encrypted)
    return base64.urlsafe_b64encode(encrypted_string)


key = raw_input("Enter password for encryption: ")
string = raw_input("Enter string to encrypt: ")
encrypted = encrypter(key, string)

print "Encrypted: " + encrypted
