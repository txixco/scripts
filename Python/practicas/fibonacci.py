#! /usr/bin/env python

def fibonacci(n):
	if (n == 0):
		return 0
	elif (n == 1):
		return 1
	else:
		return fibonacci(n-1) + fibonacci(n-2)

num = int(input("¿Cuántos números?: "))
list = [fibonacci(n) for n in range(1, num+1)]

print("Fibonacci: {}".format(list))
