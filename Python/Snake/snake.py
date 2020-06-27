#! /usr/bin/env python3

"""
Snake game
"""

import sys
import random
import pygame

from pygame.locals import QUIT

# Initialization
pygame.init()

# Colors
BLUE = (0, 0, 255)
RED = (255, 0, 0)
GREEN = (0, 255, 0)
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)

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
        self.image = pygame.image.load("enemy.png")
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


# Creating Lines and Shapes
pygame.draw.line(DISPLAY_SURF, BLUE, (150, 130), (130, 170))
pygame.draw.line(DISPLAY_SURF, BLUE, (150, 130), (170, 170))
pygame.draw.line(DISPLAY_SURF, GREEN, (130, 170), (170, 170))
pygame.draw.circle(DISPLAY_SURF, BLACK, (100, 50), 30)
pygame.draw.circle(DISPLAY_SURF, BLACK, (200, 50), 30)
pygame.draw.rect(DISPLAY_SURF, RED, (100, 200, 100, 50), 2)
pygame.draw.rect(DISPLAY_SURF, BLACK, (110, 260, 80, 5))

# Game loop
while True:
    pygame.display.update()
    for event in pygame.event.get():
        if event.type == QUIT:
            pygame.quit()
            sys.exit()

    frame_per_sec.tick(FPS)
