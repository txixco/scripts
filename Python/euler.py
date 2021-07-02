#!/usr/bin/env python3

from datetime import datetime, timedelta
from mathutils import primesProduct

MAXDIVISOR = 20

def isMultiple(n):
    for i in range(3, MAXDIVISOR+1):
        if (n % i != 0):
            return False

    return True

def smallest():
    steps = primesProduct(MAXDIVISOR)
    i = steps
    while True:
        print(f"\rCurrent: {i}", end="\r")
        if isMultiple(i):
            return i
        
        i += steps

print()
print(f"Getting the smallest multiple of all the numbers between 1 and {MAXDIVISOR}")
start = datetime.now()
print(f"The smallest number is {smallest()}")
print(f"Elapsed time: {datetime.now() - start} ")
print()