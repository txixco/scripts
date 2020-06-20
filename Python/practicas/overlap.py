#! /usr/bin/env python

def getNumbers(fileName):
    lines = open(fileName, 'r').read().splitlines()
    numbers = {n for n in lines}

    return numbers

primenumbers = getNumbers('primenumbers.txt')
happynumbers = getNumbers('happynumbers.txt')

print(primenumbers & happynumbers)
