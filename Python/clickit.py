#!/usr/bin/env python3

'''
Click on the screen until pressed <ESC>
'''

from pynput.keyboard import Key, Listener
from pynput.mouse import Button, Controller

import sys, time

# Functions
def checkKey(key):
    global finish

    if (key == Key.esc):
        finish = True

# Let's go
listener = Listener(on_press = checkKey)
listener.start()

mouse = Controller()

finish = False
while not finish:
    time.sleep(1)
    mouse.click(Button.left)
