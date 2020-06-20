#! /usr/bin/env python

import random, sys

range = range(1, 10)

while True :
	number = random.choice(range)
	guesses = 0
	print("Pensé un número entre 1 y 9, intenta adivinarlo.")
	while True :
		guesses += 1
		guess = input("Di un número: ").lower()
		if (guess == "me doy") :
			print("Era {}".format(number))
			break
		elif (guess == "sal") :
			print("Adiós")
			sys.exit()

		try :
			guess = int(guess)
			if (guess not in range) :
				raise ValueError()

		except ValueError :
			print("Tu elección ({}) no es válida".format(guess))
			continue
		
		if (guess == number) :
			print("¡Correcto! Adivinaste en {} intentos.".format(guesses))
			break
		elif (guess < number) :
			print("Demasiado bajo")
		else :
			print("Demasiado alto")
