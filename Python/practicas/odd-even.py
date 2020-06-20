#! /usr/bin/env python

def divides(x, y) :
    return not (x % y)

n = int(input("Num: "))

if divides(n, 4) :
    print("{} is a multiple of 4".format(n))
elif divides(n, 2) :
    print("{} is even".format(n))
else :
    print("{} is odd".format(n))
