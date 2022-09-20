#!/usr/bin/env python3

"""Module to define the class Deck and its relateds"""

import itertools
from random import shuffle
from typing import List

from card import Card, Rank, Suit


class Deck:
    """Class to store a deck built from Card objects"""
    deck: List[Card]

    def __init__(self) -> None:
        self.deck = [Card(rank, suit)
                          for suit, rank in itertools.product(Suit, Rank)]

    def __len__(self) -> int:
        return len(self.deck)

    def __str__(self) -> str:
        deck = [str(card) for card in self.deck]
        deck = "\n\t".join(deck)
        return f"The deck has: \n\t{deck}"

    def shuffle(self) -> None:
        """Shuffle the deck"""
        return shuffle(self.deck)

    def deal(self) -> Card:
        """Deal a card from the deck"""
        return self.deck.pop()