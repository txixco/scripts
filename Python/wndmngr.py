#!/usr/bin/env python3

'''
Script for windows management
'''

from windows_lib import Window

#with Window as wnd:
#	print(wnd.getName())

wnd = Window()
print('Name: {}'.format(wnd.getName()))
