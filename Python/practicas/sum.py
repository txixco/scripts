#!/usr/bin/env python

import sys, array

def hasSumPair(numbers, sum) :
    comp = set()

    for value in numbers :
        if (value in comp) :
            return True

        comp.add(value)

    return False

numbers = []
for number in sys.stdin :
    numbers.append(number)

print("The result is {}".format(hasSumPair(numbers, 8)))
