#! /usr/bin/env python

import random

MAXINT = 20
MINITEMS = 5
MAXITEMS = 30

def getRandomList() :
	items = random.randint(MINITEMS, MAXITEMS)
	randomList = [random.randint(1, MAXINT) for i in range(1, items + 1)]
	randomList.sort()

	print(randomList)

	return randomList

a = getRandomList()
b = getRandomList()

setA = set(a)
setB = set(b)
setC = setA.intersection(setB)

print(setC)
