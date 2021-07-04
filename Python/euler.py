#!/usr/bin/env python3

from datetime import datetime, timedelta
from mathutils import isPrime

N = 10001


print()
print(f"Getting the {N}th prime nummber")
start = datetime.now()

result = 2 if (N == 1) else 0

count = 1
i = 1
while not result:
    i = i+2
    if (isPrime(i)):
        count += 1
    
    if (count == N):
        result = i
        break

print(f"The result is: {result}")
print(f"Elapsed time: {datetime.now() - start} ")
print()