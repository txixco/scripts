#!/usr/bin/env python3

'''
Execute a command forever (or until pressed Ctrl+C, of course)
'''

# Needed libraries
from sys import argv
from subprocess import run
from time import sleep

# Let's go, Rock&Roll
if (len(argv) < 2) :
    print("You must indicate the command to be executed")
    exit(1)

command = argv[1:]

while True :
    run(command)
    sleep(1)

