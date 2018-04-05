#!/usr/bin/env python

import base64


def decrypter(key, string):
    decrypted = []
    string = base64.urlsafe_b64decode(string)
    for i in range(len(string)):
        key_c = key[i % len(key)]
        encrypted_c = chr(abs(ord(string[i]) - ord(key_c) % 256))
        decrypted.append(encrypted_c)
    decrypted_string = "".join(decrypted)
    return decrypted_string


key = raw_input("Enter password for decryption: ")
string = raw_input("Enter string to decrypt: ")
decrypted = decrypter(key, string)

print "Decrypted: " + decrypted
