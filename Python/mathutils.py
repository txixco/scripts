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

def primesProduct(n):
    product = 1
    for i in range(2, n+1):
        if isPrime(i):
            product *= i
    
    return product

