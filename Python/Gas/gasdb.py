#! /usr/bin/env python3

"""
Operations over the gas database
"""

import os
import json
from datetime import datetime

class Gas(object):
    """
    Class to represent a single gas object
    """

    def __init__(self, user, date=None):
        self.user = user
        self.date = date if date is not None else datetime.now()

class GasDB(object):
    """
    Class to represent the database
    """

    __FILE_NAME = "gas.db"

    def __init__(self):
        if not os.path.isfile(self.__FILE_NAME):
            print("Creating the file {}, as it doesn't exist".format(self.__FILE_NAME))
            with open(self.__FILE_NAME, "w") as file:
                file.write("")

    def add(self, gas):
        """
        Adds a record to the database
        """

        with open(self.__FILE_NAME) as file:
            file.write(json.dumps(gas))

    def new(self, user, date=None):
        """
        Creates a new record
        """

        date = date if date is not None else datetime.now()
        record = Gas(user, date)

        return record
