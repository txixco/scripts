#!/usr/bin/env python3

"""Module to define the class Player and its relateds"""

from typing import List

from card import Card, Rank, Suit


class Player:
    """Class to store all the player information"""

    hand: List[Card]
    name: str

    def __init__(self, name: str) -> None:
        self.name = name
        self.hand = []

    def __str__(self) -> str:
        return f"{self.name} has {len(self.hand)} cards."

    def discard(self) -> Card:
        return self.hand.pop(0)

    def draw(self, new_cards: object) -> None:
        if isinstance(new_cards, list):
            for card in new_cards:
                if not isinstance(card, Card):
                    raise TypeError
                
            self.hand.extend(new_cards)
        elif isinstance(new_cards, Card):
            self.hand.append(new_cards)
        else:
            raise TypeError
