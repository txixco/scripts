#! /usr/bin/env python3

from xml.etree.ElementTree import QName
from kivy.app import App
from kivy.uix.widget import Widget
from kivy.properties import NumericProperty
from kivy.graphics.context_instructions import Color
from kivy.graphics.vertex_instructions import Line

class MainWidget(Widget):
    # Instance constants
    V_NB_LINES = 7
    V_LINES_SPACING = 0.1

    # Instance variables
    perspective_point_x = NumericProperty(0)
    perspective_point_y = NumericProperty(0)
    
    vertical_lines = []

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.init_vertical_lines()
    
    def on_parent(self, widget, parent):
        pass

    def on_size(self, *args):
        self.update_vertical_lines()

    def on_perspective_point_x(self, widget, value):
        pass

    def on_perspective_point_y(self, widget, value):
        pass

    def init_vertical_lines(self):
        with self.canvas:
            Color(1, 1, 1)
            for i in range(self.V_NB_LINES):
                self.vertical_lines.append(Line())
    def update_vertical_lines(self):
            central_line_x = int(self.width / 2)
            spacing = self.V_LINES_SPACING * self.width
            offset = -int(self.V_NB_LINES / 2)

            for i in range(self.V_NB_LINES):
                line_x = int(central_line_x + offset*spacing)
                self.vertical_lines[i].points = [line_x, 0, line_x, self.height]
                offset += 1

class GalaxyApp(App):
    pass

GalaxyApp().run()