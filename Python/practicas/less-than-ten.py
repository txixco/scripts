#!/usr/bin/env python

max = int(input("Enter the max number: "))
numbers = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
result = [number for number in [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89] if number < max]

print(result)
