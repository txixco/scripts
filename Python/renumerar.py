#!/usr/bin/env python3
# -*- coding:  iso-8859-15 -*-

"""
Renumera los archivos de un directorio, generalmente imágenes.
"""

import argparse
from glob import glob
from os import rename

# Get the options
parser = argparse.ArgumentParser(description='Renumber the files specified by EXTension')

parser.add_argument('STRING', help='String to be used for the filenames')
parser.add_argument('EXTENSION', help='The EXTension of the files to renumber')
parser.add_argument('DIGITS', help='Digits to be used for numbering the files')

args = parser.parse_args()
DIGITS = int(args.DIGITS)
STRING = args.STRING
EXT = args.EXTENSION

if DIGITS <= 0:
    print("El número de dígitos debe ser mayor que 0")
    exit(1)

def main():
    """
    Main function, where the magic happens
    """

    cents = 10 ** DIGITS
    max_number = int("9" * DIGITS)
    num = 0
    i = 1

    files = glob("*." + EXT)
    if len(files) > max_number:
        print("La cantidad de archivos excede el número de dígitos")
        exit(1)

    for i, file in enumerate(files):
        num = str(cents + i + 1)
        num = num[1:DIGITS+1]
        new_file = "{}-{}.{}".format(STRING, num, EXT)
        print("Renaming {} to {}".format(file, new_file))
        rename(file, new_file)

# Let's go
main()
