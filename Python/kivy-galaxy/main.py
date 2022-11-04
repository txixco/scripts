#! /usr/bin/env python3

from random import randint

from kivy.config import Config
Config.set("graphics", "width", "900")
Config.set("graphics", "height", "400")

from kivy import platform
from kivy.app import App
from kivy.lang.builder import Builder
from kivy.core.window import Window
from kivy.core.audio import SoundLoader
from kivy.uix.relativelayout import RelativeLayout
from kivy.properties import ObjectProperty, StringProperty, NumericProperty, Clock
from kivy.graphics.context_instructions import Color
from kivy.graphics.vertex_instructions import Line, Quad, Triangle

Builder.load_file("menu.kv")

# Non object functions
def is_desktop():
    return platform in ("linux", "win", "macosx")

# Classes
class MainWidget(RelativeLayout):
    from transforms import transform, transform_2D, transform_perspective
    from user_actions import keyboard_closed, on_keyboard_down, on_keyboard_up, on_touch_down, on_touch_up, on_menu_button_pressed

    # Instance constants
    V_NB_LINES = 8
    V_LINES_SPACING = 0.4
    H_NB_LINES = 15
    H_LINES_SPACING = 0.1

    SPEED_X = 3
    SPEED = 0.8

    NB_TILES = 16

    SHIP_WIDTH = 0.1
    SHIP_HEIGHT = 0.035
    SHIP_BASE_Y = 0.04

    # Instance variables
    menu_widget = ObjectProperty()
    perspective_point_x = NumericProperty(0)
    perspective_point_y = NumericProperty(0)
    
    vertical_lines = []
    horizontal_lines = []

    current_offset_x = 0
    current_spacing_x = 0
    current_speed_x = 0
    current_offset_y = 0
    current_spacing_y = 0
    current_y_loop = 0

    tiles = []
    tiles_coordinates = []

    ship = None
    ship_coordinates = [(0, 0), (0, 0), (0, 0)]

    state_game_over = False
    state_game_has_started = False

    menu_title = StringProperty("G   A   L   A   X   Y")
    menu_button_title = StringProperty("START")

    score_txt = StringProperty()

    sound_begin = None
    sound_galaxy = None
    sound_gameover_impact = None
    sound_gameover_voice = None
    sound_music1 = None
    sound_restart = None

    # Magic methods
    def __init__(self, **kwargs):
        super().__init__(**kwargs)

        self.init_audio()
        self.init_vertical_lines()
        self.init_horizontal_lines()
        self.init_tiles()
        self.init_ship()
        self.reset_game()

        if is_desktop():
            self._keyboard = Window.request_keyboard(self.keyboard_closed, self)
            self._keyboard.bind(on_key_down=self.on_keyboard_down)
            self._keyboard.bind(on_key_up=self.on_keyboard_up)

        Clock.schedule_interval(self.update, 1/60)

        self.sound_galaxy.play()

    # Other instance functions    
    def reset_game(self):
        self.current_offset_y = 0
        self.current_y_loop =0
        self.current_offset_x = 0
        self.current_speed_x = 0

        self.tiles_coordinates = []
        self.pre_fill_tiles_coordinates()
        self.generate_tiles_coordinates()

        self.score_txt = "SCORE: 0"

        self.state_game_over = False

    def init_audio(self):
        self.sound_begin = SoundLoader.load("audio/begin.wav")
        self.sound_galaxy = SoundLoader.load("audio/galaxy.wav")
        self.sound_gameover_impact = SoundLoader.load("audio/gameover_impact.wav")
        self.sound_gameover_voice = SoundLoader.load("audio/gameover_voice.wav")
        self.sound_music1 = SoundLoader.load("audio/music1.wav")
        self.sound_restart = SoundLoader.load("audio/restart.wav")

        self.sound_music1.volume = 1
        self.sound_begin.volume = 0.25
        self.sound_galaxy.volume = 0.25
        self.sound_gameover_impact.volume = 0.6
        self.sound_gameover_voice.volume = 0.25
        self.sound_restart.volume = 0.25

    def init_ship(self):
        with self.canvas:
            Color(0, 0, 0)
            self.ship = Triangle()

    def init_tiles(self):
        with self.canvas:
            Color(1, 1, 1)
            for _ in range(self.NB_TILES):
                self.tiles.append(Quad())

    def pre_fill_tiles_coordinates(self):
        for i in range(10):
            self.tiles_coordinates.append((0, i))

    def generate_tiles_coordinates(self):
        last_x = 0
        last_y = 0
        
        for i in range(len(self.tiles_coordinates), 0, -1):
            if self.tiles_coordinates[i-1][1] < self.current_y_loop:
                del self.tiles_coordinates[i-1]

        if len(self.tiles_coordinates) > 0:
            last_x = self.tiles_coordinates[-1][0]
            last_y = self.tiles_coordinates[-1][1] + 1

        for _ in range(len(self.tiles_coordinates), self.NB_TILES):
            start_index = -int(self.V_NB_LINES/2) + 1
            end_index = start_index + self.V_NB_LINES - 1

            if last_x <= start_index:
                r = 1
            elif last_x >= end_index:
                r = -1
            else:
                r = randint(-1, 1)
            
            self.tiles_coordinates.append((last_x, last_y))
            if r != 0:
                last_x += r
                self.tiles_coordinates.append((last_x, last_y))
                last_y +=1
                self.tiles_coordinates.append((last_x, last_y))

            last_y += 1

    def init_vertical_lines(self):
        with self.canvas:
            Color(1, 1, 1)
            for _ in range(self.V_NB_LINES):
                self.vertical_lines.append(Line())

    def get_line_x_from_index(self, index):
        central_line_x = self.perspective_point_x
        spacing = self.V_LINES_SPACING * self.width
        offset = index - 0.5

        return central_line_x + offset*spacing + self.current_offset_x

    def get_line_y_from_index(self, index):
        return index * self.current_spacing_y - self.current_offset_y

    def get_tile_coordinates(self, ti_x, ti_y):
        ti_y -= self.current_y_loop 
        x = self.get_line_x_from_index(ti_x)
        y = self.get_line_y_from_index(ti_y)

        return x, y

    def update_ship(self):
        center_x = self.width / 2
        base_y = self.SHIP_BASE_Y * self.height
        ship_half_width = self.SHIP_WIDTH * self.width / 2
        ship_height = self.SHIP_HEIGHT * self.height

        self.ship_coordinates[0] = (center_x - ship_half_width, base_y)
        self.ship_coordinates[1] = (center_x, base_y + ship_height)
        self.ship_coordinates[2] = (center_x + ship_half_width, base_y)

        x1, y1 = self.transform(*self.ship_coordinates[0])
        x2, y2 = self.transform(*self.ship_coordinates[1])
        x3, y3 = self.transform(*self.ship_coordinates[2])

        self.ship.points = [x1, y1, x2, y2, x3, y3]

    def update_tiles(self):
        for i in range(self.NB_TILES):
            tile = self.tiles[i]
            tile_coordinates = self.tiles_coordinates[i]
            xmin, ymin = self.get_tile_coordinates(tile_coordinates[0], tile_coordinates[1])
            xmax, ymax = self.get_tile_coordinates(tile_coordinates[0]+1, tile_coordinates[1]+1)

            x1, y1 = self.transform(xmin, ymin)
            x2, y2 = self.transform(xmin, ymax)
            x3, y3 = self.transform(xmax, ymax)
            x4, y4 = self.transform(xmax, ymin)

            tile.points = [x1, y1, x2, y2, x3, y3, x4, y4] 

    def update_vertical_lines(self):
        central_line_x = int(self.width / 2)
        spacing = self.V_LINES_SPACING * self.width
        offset = -int(self.V_NB_LINES / 2) + 0.5
        start_index = -int(self.V_NB_LINES/2) + 1

        for i in range(start_index, start_index + self.V_NB_LINES):
            line_x = self.get_line_x_from_index(i)
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
        start_index = -int(self.V_NB_LINES/2) + 1
        end_index = start_index + self.V_NB_LINES - 1

        x_min = self.get_line_x_from_index(start_index)
        x_max = self.get_line_x_from_index(end_index)

        for i in range(self.H_NB_LINES):
            line_y = self.get_line_y_from_index(i)
            x1, y1 = self.transform(x_min, line_y)
            x2, y2 = self.transform(x_max, line_y)
            self.horizontal_lines[i].points = [x1, y1, x2, y2]

    def update(self, dt):
        self.update_vertical_lines()
        self.update_horizontal_lines()
        self.update_tiles()
        self.update_ship()

        time_factor = dt * 60 # So depends on the machine's speed
        
        self.current_spacing_x = self.V_LINES_SPACING * time_factor
        self.current_spacing_y = self.H_LINES_SPACING * self.height

        if not self.state_game_over and self.state_game_has_started:
            speed_x = self.current_speed_x * self.width / 100
            self.current_offset_x += speed_x * time_factor

            speed_y = self.SPEED * self.height / 100
            self.current_offset_y += speed_y * time_factor

            while self.current_offset_y >= self.current_spacing_y:
                self.current_offset_y -= self.current_spacing_y
                self.current_y_loop += 1
                self.score_txt = f"SCORE: {self.current_y_loop}"
                self.generate_tiles_coordinates()

        if not self.check_ship_collision() and not self.state_game_over:
            self.state_game_over = True
            self.menu_title = "G  A  M  E     O  V  E  R"
            self.menu_button_title = "RESTART"
            self.menu_widget.opacity = 1
            self.sound_music1.stop()
            self.sound_gameover_impact.play()
            Clock.schedule_once(self.play_game_over_voice_sound, 3)
            
    def play_game_over_voice_sound(self, dt):
        self.sound_gameover_voice.play()
    
    def check_ship_collision(self):
        for c in self.tiles_coordinates:
            if c[1] > self.current_y_loop + 1:
                return False

            if self.check_ship_collision_with_tile(*c):
                return True

        return False


    def check_ship_collision_with_tile(self, ti_x, ti_y):
        xmin, ymin = self.get_tile_coordinates(ti_x, ti_y)
        xmax, ymax = self.get_tile_coordinates(ti_x + 1, ti_y +  1)

        for i in range(3):
            px, py = self.ship_coordinates[i]
            if xmin <= px <= xmax and ymin <= py <= ymax:
                return True

        return False


class GalaxyApp(App):
    pass

GalaxyApp().run()