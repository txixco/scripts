#!/usr/bin/env python3

# This script takes a screenshot every X seconds, where X is a random integer number
# and puts it in a giver directory

from pathlib import Path
import random, pyautogui, time, argparse, os, sys

# Constants
MIN = 6#00
MAX = 18#000

# Functions
def getDirectory():
    parser = argparse.ArgumentParser(
        description='Takes a screenshot every X seconds, ' +
                    'where X is a random integer, ' +
                    'and saves it in a given directory')
    parser.add_argument(
        'DIRECTORY', 
        help='Directory to save the snapshot (default is ~/.screenshots)')

    return(parser.parse_args().DIRECTORY)

def takeSnapshot(dir):
    ''' 
    Takes a snapshot and saves it en the specified directory, returning the file name
    '''

    fileName = r'{}/{}.jpg'.format(dir, time.strftime('%Y%m%d%H%M%S'))
    print('Taking the snapshot to {}'.format(fileName))
    snapshot = pyautogui.screenshot()
    snapshot.save(fileName)
    
    return(fileName)

# Let's go
directory = getDirectory()
if not os.path.exists(directory):
    print('No se encontró el directorio {}. Se creará uno nuevo.'.format(directory))
    os.makedirs(directory)

# Take the photo
while True:
    secs = random.randint(MIN, MAX)
    print('Waiting for {} seconds...'.format(secs))
    time.sleep(secs)

    print('File: {}'.format(takeSnapshot(directory)))
    