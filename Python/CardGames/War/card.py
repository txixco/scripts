#!/usr/bin/env python3

"""Module to define the class Card and its relateds"""

from dataclasses import dataclass
from enum import Enum, auto


class Rank(Enum):
    """Class to enum the ranks of the cards"""
    ACE = 14
    TWO = 2
    THREE = 3
    FOUR = 4
    FIVE = 5
    SIX = 6
    SEVEN = 7
    EIGHT = 8
    NINE = 9
    TEN = 10
    JACK = 11
    QUEEN = 12
    KING = 13

    def __str__(self) -> str:
        return self.name.capitalize()


class Suit(Enum):
    """Class to enum the suits in the cards"""
    DIAMONDS = auto()
    CLUBS = auto()
    HEARTS = auto()
    SPADES = auto()

    def __str__(self) -> str:
        return self.name.capitalize()


@dataclass
class Card:
    """Class to store a card information"""
    rank: Rank
    suit: Suit

    def __str__(self) -> str:
        return f"{self.rank} of {self.suit}"

    def __eq__(self, __o: object) -> bool:
        return self.value == __o.value if isinstance(__o, Card) else NotImplemented

    def __gt__(self, __o: object) -> bool:
        return self.value > __o.value if isinstance(__o, Card) else NotImplemented

    def __ge__(self, __o: object) -> bool:
        return self.value >= __o.value if isinstance(__o, Card) else NotImplemented

    @property
    def value(self) -> int:
        """Property to get the value of the card"""
        return self.rank.value
