from typing import List
from card import Card, Rank

class Hand:
    cards: List[Card]
    value: int
    aces: int

    def __init__(self) -> None:
        self.cards = []
        self.value = 0
        self.aces = 0

    def add_cards(self, card: Card) -> None:
        self.cards.append(card)
        self.value += card.value

        if card.rank == Rank.ACE:
            self.aces += 1

    def adjust_for_ace(self) -> None:
        while self.value > 21 and self.aces:
            self.value -= 10
            self.aces -= 1