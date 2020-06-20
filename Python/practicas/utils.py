#! /usr/bin/env python

def getRandomList(maxInt, minItems, maxItems):
	from random import randint

	items = randint(minItems, maxItems)
	randomList = [randint(1, maxInt) for i in range(1, items + 1)]
	randomList.sort()

	return randomList

def charRange(c1, c2, step=1):
	return [chr(i) for i in range(ord(c1), ord(c2)+1, step)]

def generatePassword(set, length=""):
	import random

	if (length == ""):
		length = random.randint(8, 32)

	return "".join(random.choices(set, k=length))

def option(string, options, isInt=False):
	while True:
		try:
			answer = input(string)

			if (answer == ""):
				return (True, answer)
			elif (isInt):
				answer = int(answer)

			if (answer not in options):
				raise ValueError

			break
		except:
			print("La elección no es válida")

	return (False, answer)

def binarySearch(vector, item):
	from math import floor

	l = 0
	r = len(vector) - 1

	while (l <= r):
		m = floor((l + r) / 2)
		if (vector[m] < item):
			l = m + 1
		elif (vector[m] > item):
			r = m - 1
		else:
			return m

	return -1
