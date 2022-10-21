#!/usr/bin/env python3

from datetime import timedelta
from kivy.app import App
from kivy.metrics import dp
from kivy.clock import Clock
from kivy.uix.widget import Widget
from kivy.uix.boxlayout import BoxLayout
from kivy.graphics.vertex_instructions import Line, Rectangle, Ellipse
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
            self.rect = Rectangle(pos=(700, 200), size=(150, 100))

    def on_button_a_click(self) -> None:
        x, y = self.rect.pos
        w, h = self.rect.size
        inc = min(dp(10), self.width - (x+w))
        x += inc
        
        if (x <= self.width-w):
            self.rect.pos = (x, y)

class CanvasExample5(Widget):
    ball_size: int = dp(50)
    ball: Ellipse
    vx: int = dp(3)
    vy: int = dp(3)

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        with self.canvas:
            self.ball = Ellipse(self.center, size=(self.ball_size, self.ball_size))

        Clock.schedule_interval(self.update, 1/60)

    def on_size(self, *args) -> None:
       self.ball.pos = (self.center_x - self.ball_size/2, self.center_y - self.ball_size/2)

    def update(self, dt: timedelta) -> None:
        x, y = self.ball.pos
        nx, ny = (x+self.vx, y+self.vy)

        if (nx > self.width - self.ball_size) or (nx < 0):
            self.vx = -self.vx
            nx = x+self.vx
        
        if (ny > self.height - self.ball_size) or (ny < 0):
            self.vy = -self.vy
            ny = y+self.vy
       
        self.ball.pos = (nx, ny)

class CanvasExample6(Widget):
    pass

class CanvasExample7(BoxLayout):
    pass

TheLabApp().run()