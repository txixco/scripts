#!/usr/bin/env python3

from time import sleep
from ctypes import windll
from tkinter import Tk

import sys

# Functions
def center(win) :
    """
    Centers a tkinter window
    :param win: The root or win window to center
    """

    win.update_idletasks()
    w = win.winfo_screenwidth()
    h = win.winfo_screenheight()
    size = tuple(int(_) for _ in win.geometry().split('+')[0].split('x'))
    x = w/2 - size[0]/2
    y = h/2 - size[1]/2
    win.geometry("%dx%d+%d+%d" % (size + (x, y)))

def moveMouse(offsetX, offsetY) :
    """
    Move the mouse the indicated offset
    :param offsetX: The X offset to move
    :param offsetY: The Y offset to move
    """

    if (sys.platform == "win32") :
        windll.user32.mouse_event(0x0001, 0, offsetX, offsetY, 0)
        sleep(1)
        windll.user32.mouse_event(0x0001, 0, -offsetX, -offsetY, 0)
    else :
        pyautogui.moveRel(offsetX, offsetY)
        time.sleep(1)
        pyautogui.moveRel(-offsetX, -offsetY)

def getRoot(title, geometry="", iconBitmap="") :
    """
    Gets a Tk window, with some attribute values
    :param title: The window title
    :param iconBitmap: The window icon
    :param geometry: The window width and height
    """

    root = Tk()
    root.title(title)

    if geometry != "" :
        root.geometry(geometry)

    if iconBitmap != "" :
        root.iconbitmap(iconBitmap)

    return root
