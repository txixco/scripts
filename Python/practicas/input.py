#! /usr/bin/env python

from datetime import date

name = input("Name: ")
age = int(input("Age: "))
reps = int(input("Repetitions: "))

year = date.today().year + (100 - age + 1)

for i in range(reps) :
    print("Hi {}, you'll be 100 years old in {}".format(name, year))
