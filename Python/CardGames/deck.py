#!/usr/bin/env python3

import enum

# Enum for the suits
class Suits(enum.Enum):
    Oros = 'Oros'
    Bastos = 'Bastos'
    Copas = 'Copas'
    Espadas = 'Espadas'

# Class for the deck
class Deck:
    # Members
    deck = ""

    #Constructor
    def __init__(self):
        for suit in range(1, 5):
            for card in range(1, 13):
                self.deck[suit][card] = Suits[suit]

# Class for the cards
class Card:
    # Constructor
    def __init__(self, palo, valor):
        self.palo = palo
        self.valor = valor

    # Métodos
