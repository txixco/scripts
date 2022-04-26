#!/usr/bin/env python3

"""Module to define the class Player and its relateds"""

from typing import List

from card import Card


class Player:
    """Class to store all the player information"""

    hand: List[Card]

    def __init__(self) -> None:
        pass
