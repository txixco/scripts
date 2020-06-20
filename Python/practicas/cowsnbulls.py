#! /usr/bin/env python

from random import choices
from utils import charRange

def pluralize(number, string):
	if (number == 1):
		return "{} {}".format(number, string)
	else:
		return "{} {}s".format(number, string)

numbers = charRange("0", "9")
number = choices(numbers, k=4)
print("Ya pensé un número de 4 cifras")

guesses = 0
while True:
	guess = input("Introduce un número: ")
	guesses += 1

	if (guess.lower() == "me doy"):
		print("El número era {}".format("".join(number)))
		break

	if (len(guess) != 4):
		print("Debe ser un número de 4 cifras")
		continue

	error = False
	cows = 0
	bulls = 0
	for i in range(0, 4):
		if (guess[i] not in numbers):
			print("Debes introducir un número")
			error = True
		elif (guess[i] == number[i]):
			cows += 1
		elif (guess[i] in number):
			bulls += 1

	if (error):
		break

	if (cows == 4):
		number = "".join(number)
		print("¡Correcto, adivinaste en {}! El número era {}"
				.format(pluralize(guesses, "intento"), "".join(number)))
		break
	else:
		print("{}, {}".format(pluralize(cows, "cow"), 
							  pluralize(bulls, "bull")))
