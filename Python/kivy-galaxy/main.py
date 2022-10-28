#! /usr/bin/env python3

from kivy.config import Config
Config.set("graphics", "width", "900")
Config.set("graphics", "height", "400")

from kivy import platform
from kivy.app import App
from kivy.core.window import Window
from kivy.uix.widget import Widget
from kivy.properties import NumericProperty, Clock
from kivy.graphics.context_instructions import Color
from kivy.graphics.vertex_instructions import Line

# Non object functions
def is_desktop():
    return platform in ("linux", "win", "macosx")

# Classes
class MainWidget(Widget):
    # Instance constants
    V_NB_LINES = 10
    V_LINES_SPACING = 0.25
    H_NB_LINES = 15
    H_LINES_SPACING = 0.1

    SPEED_X = 12
    SPEED_Y = 3

    # Instance variables
    perspective_point_x = NumericProperty(0)
    perspective_point_y = NumericProperty(0)
    
    vertical_lines = []
    horizontal_lines = []

    current_offset_x = 0
    current_spacing_x = 0
    current_speed_x = 0
    current_offset_y = 0
    current_spacing_y = 0

    # Magic methods
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.init_vertical_lines()
        self.init_horizontal_lines()

        if is_desktop():
            self._keyboard = Window.request_keyboard(self.keyboard_closed, self)
            self._keyboard.bind(on_key_down=self.on_keyboard_down)
            self._keyboard.bind(on_key_up=self.on_keyboard_up)

        Clock.schedule_interval(self.update, 1/60)

    # Events
    def on_parent(self, widget, parent):
        pass

    def on_size(self, *args):
        pass

    def on_perspective_point_x(self, widget, value):
        pass

    def on_perspective_point_y(self, widget, value):
        pass

    def on_touch_down(self, touch):
        if touch.x < self.width/2:
            self.current_speed_x = -self.SPEED_X
        else:
            self.current_speed_x = self.SPEED_X

    def on_touch_up(self, touch):
        self.current_speed_x = 0

    def keyboard_closed(self):
        self._keyboard.unbind(on_key_down=self.on_keyboard_down)
        self._keyboard.unbind(on_key_up=self.on_keyboard_up)
        self._keyboard = None

    def on_keyboard_down(self, keyboard, keycode, text, modifiers):
        match keycode[1]:
            case "left":
                self.current_speed_x = -self.SPEED_X
            case "right":
                self.current_speed_x = self.SPEED_X
            case _:
                pass

        return True

    def on_keyboard_up(self, keyboard, keycode):
        self.current_speed_x = 0

        return True

    # Other instance functions    
    def init_vertical_lines(self):
        with self.canvas:
            Color(1, 1, 1)
            for _ in range(self.V_NB_LINES):
                self.vertical_lines.append(Line())

    def update_vertical_lines(self):
        central_line_x = int(self.width / 2)
        spacing = self.V_LINES_SPACING * self.width
        offset = -int(self.V_NB_LINES / 2) + 0.5

        for i in range(self.V_NB_LINES):
            line_x = int(central_line_x + offset * spacing + self.current_offset_x)
            x1, y1 = self.transform(line_x, 0)
            x2, y2 = self.transform(line_x, self.height)
            self.vertical_lines[i].points = [x1, y1, x2, y2]
            offset += 1

    def init_horizontal_lines(self):
        with self.canvas:
            Color(1, 1, 1)
            for _ in range(self.H_NB_LINES):
                self.horizontal_lines.append(Line())

    def update_horizontal_lines(self):
        central_line_x = int(self.width / 2)
        spacing = self.V_LINES_SPACING * self.width
        offset = -int(self.V_NB_LINES / 2) + 0.5

        x_min = central_line_x + offset * spacing + self.current_offset_x
        x_max = central_line_x - offset * spacing + self.current_offset_x

        for i in range(self.H_NB_LINES):
            line_y = i * self.current_spacing_y - self.current_offset_y
            x1, y1 = self.transform(x_min, line_y)
            x2, y2 = self.transform(x_max, line_y)
            self.horizontal_lines[i].points = [x1, y1, x2, y2]

    def transform(self, x, y):
        # return self.transform_2D(x, y)
        return self.transform_perspective(x, y)

    def transform_2D(self, x, y):
        return x, y

    def transform_perspective(self, x, y):
        lin_y = y * self.perspective_point_y / self.height

        diff_x = x - self.perspective_point_x
        diff_y = self.perspective_point_y - lin_y
        factor_y = diff_y / self.perspective_point_y
        factor_y = factor_y ** 4

        tr_x = self.perspective_point_x + diff_x * factor_y
        tr_y = (1 - factor_y) * self.perspective_point_y

        return int(tr_x), int(tr_y)

    def update(self, dt):
        self.update_vertical_lines()
        self.update_horizontal_lines()

        time_factor = dt * 60 # So depends on the machine's speed
        self.current_offset_x += self.current_speed_x * time_factor
        self.current_spacing_x = self.V_LINES_SPACING * time_factor

        self.current_offset_y += self.SPEED_Y * dt * 60 # So depends on the machine's speed
        self.current_spacing_y = self.H_LINES_SPACING * self.height

        if self.current_offset_y >= self.current_spacing_y:
            self.current_offset_y -= self.current_spacing_y
        
class GalaxyApp(App):
    pass

GalaxyApp().run()