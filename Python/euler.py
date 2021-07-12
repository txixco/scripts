#!/usr/bin/env python3

from datetime import datetime, timedelta
from mathutils import isPrime

MAXNUMBER = 2_000_000

print()
print(f"Getting the sum of the primes below {MAXNUMBER}")
start = datetime.now()

primes = [ i for i in range(2, MAXNUMBER+1) if isPrime(i) ]

print(f"The sum is {sum(primes)}")
print(f"Elapsed time: {datetime.now() - start} ")
print()