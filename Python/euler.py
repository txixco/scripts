#!/usr/bin/env python3

from datetime import datetime, timedelta

## Constants

NUMBER = 600851475143

## Functions

# Print iterations progress
def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '█', printEnd = "\r"):
    """
    Call in a loop to create terminal progress bar
    @params:
        iteration   - Required  : current iteration (Int)
        total       - Required  : total iterations (Int)
        prefix      - Optional  : prefix string (Str)
        suffix      - Optional  : suffix string (Str)
        decimals    - Optional  : positive number of decimals in percent complete (Int)
        length      - Optional  : character length of bar (Int)
        fill        - Optional  : bar fill character (Str)
        printEnd    - Optional  : end character (e.g. "\r", "\r\n") (Str)
    """
    percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
    filledLength = int(length * iteration // total)
    bar = fill * filledLength + '-' * (length - filledLength)
    print(f'\r{prefix} |{bar}| {percent}% {suffix}', end = printEnd)
    # Print New Line on Complete
    if iteration == total: 
        print()

# Validate if a number is prime
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

# Do the trick  
def maxFactor(n):
  max = 0
  if (n%2 == 0):
      max = 2

  for i in range(3, n+1, 2):
    printProgressBar(i, n, prefix = '', suffix = '', length = 50)
    if (isPrime(i) and (n%i == 0)):
      max = i

  return max

## Main

start = datetime.now()
print()
print(f"Getting the max prime factor for {NUMBER}")
print(f"Started at: {start:%d-%m-%Y %H:%M:%S}")
print(f"Max. Factor: {maxFactor(NUMBER)}")
end = datetime.now()
print(f"Finished at: {end:%d-%m-%Y %H:%M:%S}")
print(f"Elapsed time: {end - start} ")
print()