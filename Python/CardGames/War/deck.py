#!/usr/bin/env python3

"""Module to define the class Deck and its relateds"""

import itertools
from random import shuffle
from typing import List

from card import Card, Rank, Suit


class Deck:
    """Class to store a deck built from Card objects"""
    all_cards: List[Card]

    def __init__(self) -> None:
        self.all_cards = [Card(rank, suit)
                          for suit, rank in itertools.product(Suit, Rank)]

    def __len__(self) -> int:
        return len(self.all_cards)

    def shuffle(self) -> None:
        """Shuffle the deck"""
        return shuffle(self.all_cards)

    def deal(self) -> Card:
        """Deal a card from the deck"""
        return self.all_cards.pop()
