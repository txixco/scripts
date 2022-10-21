#!/usr/bin/env python3

from kivy.app import App
from kivy.metrics import dp
from kivy.uix.widget import Widget
from kivy.graphics.vertex_instructions import Line, Rectangle
from kivy.graphics.context_instructions import Color

class MainWidget(Widget):
    pass

class TheLabApp(App):
    pass

class CanvasExample1(Widget):
    pass

class CanvasExample2(Widget):
    pass

class CanvasExample3(Widget):
    pass

class CanvasExample4(Widget):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        with self.canvas:
            Line(points=(100, 100, 400, 500), width=2)
            Color(0, 1, 0)
            Line(circle=(400, 200, 80), width=2)
            Line(rectangle=(700, 500, 150, 100), width=5)
            Rectangle(pos=(700, 200), size=(150, 100))

TheLabApp().run()