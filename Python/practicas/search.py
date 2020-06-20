#! /usr/bin/env python

import utils, random

nums = utils.getRandomList(100, 5, 30)
nums = list(set(nums))
nums.sort()

print("La lista es: {}".format(nums))

while True:
	(isEmpty, item) = utils.option("Introduzca un número: ", 
								   range(1, 100), 
								   True)

	if (not isEmpty):
		break

pos = utils.binarySearch(nums, item)

if (pos == -1):
	print("El número {} no está en la lista".format(item))
else:
	print("El número {} está en la posición {}".format(item, pos))
