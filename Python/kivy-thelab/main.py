#!/usr/bin/env python3

from kivy.app import App
from kivy.metrics import dp
from kivy.properties import StringProperty, BooleanProperty
from kivy.uix.textinput import TextInput
from kivy.uix.slider import Slider
from kivy.uix.switch import Switch
from kivy.uix.togglebutton import ToggleButton
from kivy.uix.button import Button
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.anchorlayout import AnchorLayout
from kivy.uix.gridlayout import GridLayout
from kivy.uix.stacklayout import StackLayout
from kivy.uix.widget import Widget

class WidgetsExample(GridLayout):
    my_text: str = StringProperty("Hello!")
    text_input_str: str = StringProperty("foo")
    counter: int = 0

    def __init__(self, **kwargs):
        super().__init__(**kwargs)

    def on_toggle_button_state(self, widget: ToggleButton) -> None:
        widget.text = "OFF" if (widget.state == "normal") else "ON"

    def on_button_clicked(self) -> None:
        self.counter += 1
        self.my_text = str(self.counter)

    def on_text_validate(self, widget: TextInput) -> None:
        self.text_input_str = widget.text

class StackLayoutExample(StackLayout):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.orientation = "rl-bt" # Right to left and bottom to top
        # self.padding = ("40dp", "40dp", "40dp", "40dp") # Left Top Right Bottom
        # self.spacing = ("20dp", "20dp") # Horizontal Vertical

        for i in range(10):
            #size = dp(100) + i*10
            size = dp(100)
            b = Button(text=str(i+1), size_hint=(None, None), size=(size, size))
            self.add_widget(b)

# class GridLayoutExample(GridLayout):
#     pass

class AnchorLayoutExample(AnchorLayout):
    pass

class BoxLayoutExample(BoxLayout):
    pass

class MainWidget(Widget):
    pass

class TheLabApp(App):
    pass

TheLabApp().run()