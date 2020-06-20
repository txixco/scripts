#!/usr/bin/env python3

'''
Some window management functions
'''

import gi

gi.require_version('Wnck', '3.0')
gi.require_version('Gtk', '3.0')

from gi.repository import Gtk, Wnck

class Window(Wnck.Window):
	def __init__(self):
		super().__init__()

	def __enter__(self):
		return self

	def __exit__(self, exc_type, exc_value, traceback):
		screen = None
		Wnck.shutdown()

	def getName(self):
		return self.get_name()

	def getGeometry(self):
		return self.get_geometry()

	def setGeometry(self, x, y):
		self.set_geometry('+{}+{}'.format(x,y))

	def center(self):
		self.setPosition(100, 200)

Gtk.init([])
screen = Wnck.Screen.get_default()
screen.force_update()
wnd = screen.get_active_window()
wnd.__class__ = Window
