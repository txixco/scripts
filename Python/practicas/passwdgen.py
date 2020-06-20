#! /usr/bin/env python

import utils, random

def randomIfEmpty(isEmpty, number, myRange):
	if (isEmpty):
		print("Al no elegir, será aleatorio")
		return random.choice(myRange)

	return number

while True:
	(isEmpty, type) = utils.option("PIN o contraseña ('P', 'C'): ", 
								   [ "P", "p", "C", "c"])

	if (not isEmpty):
		break

type = type.lower()
if (type == "p"):
	sets = [utils.charRange('0', '9')]
	(isEmpty, length) = utils.option("Elija la longitud (16 máximo): ", 
									 range(1, 17), 
									 True)
	length = randomIfEmpty(isEmpty, length, range(1, 17))
	level = 1
else:
	sets = [ utils.charRange('A', 'Z'), 
			 utils.charRange('a', 'z'), 
			 utils.charRange('0', '9'), 
			 utils.charRange('#', '&')
		   ]

	(isEmpty, level) = utils.option("Elija el nivel de seguridad (1-4): ", 
									range(1, 5), 
									True)
	level = randomIfEmpty(isEmpty, level, range(1, 5))

chars = []
for i in range(0, level):
	chars += sets[i]

if (type == "p"):
	print("El PIN es: {}".format(utils.generatePassword(chars, length)))
else:
	print("La contraseña es: {}".format(utils.generatePassword(chars)))
