#!/usr/bin/env python3

'''
Moves the mouse pointer every WAIT seconds.
'''


import os
os.environ["KIVY_NO_CONSOLELOG"] = "1"

from winutils import move_mouse

from kivy.config import Config
Config.set("graphics", "width", "300")
Config.set("graphics", "height", "50")
Config.set("graphics", "resizable", "False")
Config.set("kivy", "window_icon", "moveit.png")

from kivy.core.window import Window
Window.clearcolor = (0.9, 0.9, 0.9)

from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.properties import StringProperty
from kivy.clock import Clock

# Constants
OFFSET_X = 100
OFFSET_Y = 100
WAIT = 60
SECS = "second" + ("" if (WAIT == 1) else "s")
MOVING_STR = f"Moving the mouse every {WAIT} {SECS}"   

# The classes
class MainBox(BoxLayout):
    countdown: str = StringProperty("")
    moving: str = StringProperty("")
    remains: int = WAIT

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.moving = MOVING_STR

        Clock.schedule_interval(lambda dt: self.update(), 1)

    def update(self):
        if self.remains >= 0:
            self.countdown = str(self.remains)
            self.remains -= 1
        else:
            move_mouse(OFFSET_X, OFFSET_Y)
            self.remains = WAIT
        
class MoveitApp(App):
    pass

# Allons'y!
MoveitApp().run()