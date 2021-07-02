#!/usr/bin/env python3

from datetime import datetime, timedelta

DIGITS = 3

def maxPalindrome(digits):
    min = 10 ** (digits-1)
    max = (10 ** digits) - 1
    maxPal = 0

    for i in range(min, max+1):
        for j in range(i, max+1):
            num = i * j
            if ((str(num) == str(num)[::-1]) and (num > maxPal)):
                ret = (i, j, num)
                maxPal = num

    return ret

print()
print(f"Getting the max palindrome, product of two numbers of {DIGITS} digits")
start = datetime.now()
(num1, num2, res) = maxPalindrome(DIGITS)
print(f"The max palindrome number is {num1} x {num2} = {res}")
print(f"Elapsed time: {datetime.now() - start} ")
print()