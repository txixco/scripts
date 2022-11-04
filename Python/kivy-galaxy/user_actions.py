from kivy.uix.relativelayout import RelativeLayout

def keyboard_closed(self):
    self._keyboard.unbind(on_key_down=self.on_keyboard_down)
    self._keyboard.unbind(on_key_up=self.on_keyboard_up)
    self._keyboard = None

def on_keyboard_down(self, keyboard, keycode, text, modifiers):
    match keycode[1]:
        case "right":
            self.current_speed_x = -self.SPEED_X
        case "left":
            self.current_speed_x = self.SPEED_X
        case _:
            pass

    return True

def on_keyboard_up(self, keyboard, keycode):
    self.current_speed_x = 0

    return True

def on_touch_down(self, touch):
    if not self.state_game_over and self.state_game_has_started:
        if touch.x < self.width/2:
            self.current_speed_x = -self.SPEED_X
        else:
            self.current_speed_x = self.SPEED_X

    return super(RelativeLayout, self).on_touch_down(touch)

def on_touch_up(self, touch):
    self.current_speed_x = 0

def on_menu_button_pressed(self):
    if self.state_game_over:
        self.sound_restart.play()
    else:
        self.sound_begin.play()

    self.sound_music1.play()

    self.reset_game()
    self.state_game_has_started = True
    self.menu_widget.opacity = 0