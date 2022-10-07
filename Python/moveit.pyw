#!/usr/bin/env python3

'''
Moves the mouse pointer every WAIT seconds.
'''


from tkinter import *
import time, pyautogui, winutils

# Constants
OFFSET_X = 100
OFFSET_Y = 100
WAIT = 60
SECS = "second" + ("" if (WAIT == 1) else "s")
MOVING = f"Moving the mouse every {WAIT} {SECS}"   

# Defining the dialog
root = winutils.getRoot("Move It", "300x50", "mouse-move.ico")
root.resizable(width=False, height=False)
winutils.center(root)

countdown = StringVar()

Label(root, text=MOVING).pack()
Label(root, textvariable=countdown).pack()

# Let's go
pyautogui.FAILSAFE = True

while True:
    for remains in range(WAIT, 0, -1):
        countdown.set(f"The next movement will be on {remains} {SECS}...")
        root.update()
        time.sleep(1)

    countdown.set("Moving...")
    root.update()

    winutils.moveMouse(OFFSET_X, OFFSET_Y)
