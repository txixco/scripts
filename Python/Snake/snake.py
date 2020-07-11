#! /usr/bin/env python3

"""
Snake game
"""

import sys
import random
import pygame

from pygame.locals import QUIT, K_LEFT, K_RIGHT

# Initialization
pygame.init()
DISPLAYSURF = pygame.display.set_mode((300, 300))

# Colors
BLUE = (0, 0, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)

# Others
SCREEN_WIDTH = 400
SCREEN_HEIGHT = 600
SPEED = 5

# FPS
FPS = 60
frame_per_sec = pygame.time.Clock()

# Setup a 300x300 pixel display with caption
DISPLAY_SURF = pygame.display.set_mode((300, 300))
DISPLAY_SURF.fill(WHITE)
pygame.display.set_caption("Game")

# Classes

class Enemy(pygame.sprite.Sprite):
    """
    Class to represent the enemy
    """
    def __init__(self):
        super().__init__()
        self.image = pygame.image.load("Enemy.png")
        self.surf = pygame.Surface((50, 80))
        self.rect = self.surf.get_rect(center=(random.randint(40, 360), 0))

    def move(self):
        """
        Moves the enemy
        """
        self.rect.move_ip(0, 10)
        if self.rect.bottom > 600:
            self.rect.top = 0
            self.rect.center = (random.randint(30, 370), 0)

    def draw(self, surface):
        """
        Draws the enemy
        """
        surface.blit(self.image, self.rect)


class Player(pygame.sprite.Sprite):
    """
    Class for the player
    """
    def __init__(self):
        super().__init__()
        self.image = pygame.image.load("Player.png")
        self.surf = pygame.Surface((50, 100))
        self.rect = self.surf.get_rect()

    def update(self):
        """
        Update the screen
        """
        pressed_keys = pygame.key.get_pressed()
       #if pressed_keys[K_UP]:
            #self.rect.move_ip(0, -5)
       #if pressed_keys[K_DOWN]:
            #self.rect.move_ip(0,5)

        if self.rect.left > 0:
            if pressed_keys[K_LEFT]:
                self.rect.move_ip(-5, 0)
        if self.rect.right < SCREEN_WIDTH:
            if pressed_keys[K_RIGHT]:
                self.rect.move_ip(5, 0)

    def draw(self, surface):
        """
        Draw the screen
        """
        surface.blit(self.image, self.rect)


P1 = Player()
E1 = Enemy()

while True:
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()
    P1.update()
    E1.move()

    DISPLAYSURF.fill(WHITE)
    P1.draw(DISPLAYSURF)
    E1.draw(DISPLAYSURF)

    pygame.display.update()
    frame_per_sec.tick(FPS)
