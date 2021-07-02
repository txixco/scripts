#!/usr/bin/env python3

from datetime import datetime, timedelta

NUMBER = 600851475143

def isPrime(n):
    if (n <= 3):
        return (n > 1)

    if (n % 2 == 0) or n % 3 == 0:
        return False

    i = 5
    while (i ** 2 <= n):
        if (n % i == 0) or (n % (i+2) == 0):
            return False
        
        i += 6

    return True

def maxFactor(n):
    for i in range(2, n):
        if (isPrime(i) and (n%i == 0)):
            return maxFactor(int(n/i))

    return n

# Main

start = datetime.now()
print()
print(f"Getting the max prime factor for {NUMBER}")
print(f"Started at: {start:%d-%m-%Y %H:%M:%S}")
print(f"Max. Factor: {maxFactor(NUMBER)}")
end = datetime.now()
print(f"Finished at: {end:%d-%m-%Y %H:%M:%S}")
print(f"Elapsed time: {end - start} ")
print()