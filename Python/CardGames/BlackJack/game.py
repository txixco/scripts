#!/usr/bin/env python3

"""Module for the game class"""

from typing import List

from card import Card
from deck import Deck
from hand import Hand
from chips import Chips

class Game:
    """Class for a game"""

    deck: Deck
    chips: Chips
    player: Hand
    dealer: Hand
    playing: bool

    def __init__(self) -> None:
        self.deck = Deck()
        self.deck.shuffle()
        
        self.player = Hand()
        self.player.add_cards(self.deck.deal())
        self.player.add_cards(self.deck.deal())

        self.dealer = Hand()
        self.dealer.add_cards(self.deck.deal())
        self.dealer.add_cards(self.deck.deal())

        self.chips = Chips()
        self.take_bet()

    def take_bet(self) -> None:
        while True:
            try:
                self.chips.bet = int(input("How many chips would you like to bet? "))
            except Exception:
                print("Sorry, provide an integer")
            
            if self.chips.bet > self.chips.total:
                print(f"Sorry, you don't have enough chips! You have: {self.chips.total}")
            else:
                break

    def hit(self, player: Hand) -> None:
        player.add_cards(self.deck.deal())
        player.adjust_for_ace()

    def hit_or_stand(self) -> None:
        while True:
            x = input("[H]it or [S]tand? ")

            match x.lower():
                case "h":
                    self.hit(self.player)
                    break
                case "s":
                    print("Player stands, dealer's turn")
                    self.playing = False
                    break
                case _:
                    print("Sorry, I don't understand your response")
    
    def show_some(self) -> None:
        print("\nDealer's hand: ")
        print("First card is hidden")
        print(self.dealer.cards[1])

        print("\nPlayer's hand: ", *self.player.cards, sep="\n")

    def show_all(self) -> None:
        print("\nDealer's hand: ", *self.dealer.cards, sep="\n")
        print(f"The value for the dealer's card is: {self.dealer.value}")

        print("\nPlayer's hand: ", *self.player.cards, sep="\n")
        print(f"The value for the player's card is: {self.player.value}")
        
    def player_busts(self) -> None:
        print("Bust player!")
        self.chips.lose_bet()

    def player_wins(self) -> None:
        print("Player wins!")
        self.chips.win_bet()

    def dealer_busts(self) -> None:
        print("Player wins, dealer busted!")
        self.chips.win_bet()

    def dealer_wins(self) -> None:
        print("Dealer wins!")
        self.chips.lose_bet()

    def push(self) -> None:
        print("Player and dealer tie! PUSH")
    
    def play(self) -> None:
        self.show_some()

        self.playing = True
        while self.playing:
            self.hit_or_stand()
            self.show_some()

            if self.player.value > 21:
                self.player_busts()
                break

        if self.player.value <= 21:
            while self.dealer.value < self.player.value:
                self.hit(self.dealer)

            self.show_all()

            if self.dealer.value > 21:
                self.dealer_busts()
            elif self.dealer.value > self.player.value:
                self.dealer_wins()
            elif self.dealer.value < self.player.value:
                self.player_wins()
            else:
                self.push()

        print(f"\nPlayer's total chips are: {self.chips.total}")

def main() -> None:
    print("Welcome to Blackjack")
    while True:
        game = Game()
        game.play()
        
        while True:
            new_game = input("Would you like to play another hand? [y/n]").lower()
            if new_game in ["y", "n"]:
                break

            print("Sorry, the response is not valid")

        if new_game == "n":
            print("Thank you for playing!")
            break

if __name__ == "__main__":
    main()