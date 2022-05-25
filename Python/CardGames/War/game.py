#!/usr/bin/env python3

"""Module for the game class"""

from typing import List

from card import Card
from deck import Deck
from player import Player

class Game:
    """Class for a game"""

    WAR_CARDS_NUM = 5

    player_one: Player
    player_two: Player
    deck: Deck

    def __init__(self, player_one: Player, player_two: Player) -> None:
        self.player_one = player_one
        self.player_two = player_two
        
        self.deck = Deck()
        self.deck.shuffle()
        self.deck.deal( [player_one, player_two] )

    def play(self) -> Player:
        round_num = 0
        while True:
            round_num += 1
            print(f"Round {round_num}")

            if len(self.player_one.hand) == 0:
                return self.player_two

            if len(self.player_two.hand) == 0:
                return self.player_one

            # Begin the round
            player_one_cards = [self.player_one.discard()]
            player_two_cards = [self.player_two.discard()]
            at_war = True

            while at_war:
                if player_one_cards[-1] > player_two_cards[-1]:
                    self.player_one.draw(player_one_cards)
                    self.player_one.draw(player_two_cards)
                    at_war = False
                elif player_two_cards[-1] > player_one_cards[-1]:
                    self.player_two.draw(player_two_cards)
                    self.player_two.draw(player_one_cards)
                    at_war = False
                else:
                    print("WAR!")

                    if len(self.player_one.hand) < self.WAR_CARDS_NUM:
                        return self.player_two

                    if len(self.player_two.hand) < self.WAR_CARDS_NUM:
                        return self.player_one

                    for _ in range(self.WAR_CARDS_NUM):
                        player_one_cards.append(self.player_one.discard())
                        player_two_cards.append(self.player_two.discard())


game = Game(Player("one"), Player("two"))
print(f"{game.play().name} wins!")