#!/usr/bin/env python3

import time

def calculate(words, time) :
    mins, secs = int(time[0]), int(time[1])
    secs += mins * 60

    return words / secs * 60

if __name__ == '__main__' :
    words = int(input('How many words have you read? '))
    time = input('During how long? (mm:ss) ').split(":")

    print('Words per minute = ' + '{:.2f}'.format(calculate(words, time)))
