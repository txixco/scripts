#!/usr/bin/env python3

from datetime import datetime, timedelta
from mathutils import primesProduct

N = 100

print()
print(f"Getting the difference between the sum of squares and the square of the sum of the first {N} numbers")
start = datetime.now()
sumOfSquares = N * (N + 1) * (2*N + 1)/6
squareOfSum = ((N+1) * (N // 2)) ** 2
print(f"The difference is {squareOfSum - sumOfSquares}")
print(f"Elapsed time: {datetime.now() - start} ")
print()