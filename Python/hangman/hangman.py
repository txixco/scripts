#! /usr/bin/env python

"""
Traditional Hangman game, for 2 players
"""

from interface import CLIInterface

# Constants
MAX_TRIES = 10

# Variables
secret_word: str
current_word: str

# Functions
def validate_letter(word: str, letter: chr) -> list:
    return [ pos for pos, char in enumerate(word) if char == letter ]

# Allons'y!
def main():
    interface = CLIInterface()

    secret_word = interface.ask_word()
    current_word = list("_" * len(secret_word))

    tries = MAX_TRIES
    while tries and "_" in current_word:
        interface.show_word(current_word)
        guess = interface.ask_letter()

        valid_pos = validate_letter(word=secret_word, letter=guess)
        if not valid_pos:
            tries -= 1
            continue

        for i in valid_pos:
             current_word[i] = guess

    if tries:
        interface.show_winner("Player 2")
    else:
        interface.show_winner("Player 1")

if __name__ == "__main__":
    main()
