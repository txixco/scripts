from typing import Protocol


class Interface(Protocol):
    """Class to define a protocol for the UI"""


    def input_field(self, options: str) -> None:
       """Returns the answer of the user""" 
    
    def choose_value(self, field: str, values: list) -> str:
        """Returns a value chosen by the user from a list"""

    def check_field(self, fields: dict) -> str:
        """Returns a checkbox to be selected"""