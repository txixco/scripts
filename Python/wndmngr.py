#!/usr/bin/env python3

'''
Script for windows management
'''

from windows_lib import Window

wnd = Window()
print(f'Name: {wnd.getName()}\nGeometry: {wnd.getGeometry()}')
wnd.setGeometry(10, 10)