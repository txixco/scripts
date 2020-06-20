#! /usr/bin/env python


def getNames(fileName):
    names = {}
    lines = open(fileName, 'r').read().splitlines()
    for line in lines:
        if not line in names:
            names[line] = 0
        names[line] += 1

    return names

fileName = input("Dime el nombre del archivo: ")
names = getNames(fileName)

print(names)
