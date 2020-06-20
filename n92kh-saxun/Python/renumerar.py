#!/usr/bin/env python3
# -*- coding:  iso-8859-15 -*-

'''
Renumera los archivos de un directorio, generalmente imágenes.
'''

import sys
from glob import glob
from os import rename

def getDigits(src) :
    try :
        digits = int(src)
    except ValueError :
        print('El tercer argumento debe ser un número')
        exit(1)

    if (digits <= 0) :
        print('El número de dígitos debe ser mayor que 0')
        exit(1)

    return digits

if (len(sys.argv) < 3) :
    print('El número de argumentos no es válido, deben ser 3')
    exit(1)

cadena = sys.argv[1]
ext = sys.argv[2]
digits = getDigits(sys.argv[3])

cents = 10 ** digits
maxNumber = int('9' * digits)
num = 0
i = 1

files = glob('*.' + ext)
if (len(files) > maxNumber) :
    print('La cantidad de archivos excede el número de dígitos')
    exit(1)

for i, file in enumerate(files) :
    num = str(cents + i + 1)
    num = num[1:digits+1]
    newFile = '{}-{}.{}'.format(cadena, num, ext)
    print('Renaming {} to {}'.format(file, newFile))
    rename(file, newFile)
