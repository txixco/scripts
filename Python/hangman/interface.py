from getpass import getpass
from typing import Protocol

"""
Module for the Hangman interface
"""

class Interface(Protocol):
    def ask_word(self) -> str:
        ...

    def ask_letter(self) -> chr:
        ...

    def show_word(self, letter: chr) -> None:
        ...

class CLIInterface:
    def ask_word(self) -> list:
        return getpass("Introduce una palabra: ").lower()

    def ask_letter(self) -> chr:
        return input("Introduce una letra: ")[0].lower()

    def show_word(self, word: list) -> None:
        print("".join(word))

    def show_winner(self, winner):
        print(f"The winner is: {winner}")