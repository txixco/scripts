#! /usr/bin/env python

def getCategories(fileName):
    categories = {}
    lines = open(fileName, 'r').read().splitlines()
    for line in lines:
        category = line.split('/')[2]
        if not category in categories:
            categories[category] = 0
        categories[category] += 1

    return categories

fileName = 'Training_01.txt'
categories = getCategories(fileName)

print(categories)
