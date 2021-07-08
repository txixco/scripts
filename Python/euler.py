#!/usr/bin/env python3

from datetime import datetime, timedelta
from math import sqrt

FSUM = 1000

def triplet(n):
    for a in range(1, n // 3):
        for b in range(a+1, (n - a) // 2):
            c = n - a - b
            if (a**2 + b**2 == c**2):
                return (a, b, c)

print()
print(f"Getting the Pythagorean Triplet for which a+b+c = 1000")
start = datetime.now()

(a, b, c) = triplet(FSUM)

print(f"The triplet is {(a, b, c)}")
print(f"The product is: {a * b * c}")
print(f"Elapsed time: {datetime.now() - start} ")
print()