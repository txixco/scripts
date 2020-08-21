#! /usr/bin/env python3

"""
Operations over the gas database
"""

import os
import pickle

from datetime import datetime

class Gas(object):
    """
    Class to represent a single gas object
    """

    def __init__(self, user, date=None):
        self.user = user
        self.date = date if date is not None else datetime.now()

    def __repr__(self):
        return "{}|{}".format(self.user, self.date)

    def __str__(self):
        return "User: {}\nDate: {}".format(self.user, self.date)

class GasDB(object):
    """
    Class to represent the database
    """

    __FILE_NAME = "{}{}gas.db".format(os.path.dirname(os.path.realpath(__file__)), os.sep)
    __USERS = ["txixco", "joshurm", "ara"]

    def __init__(self):
        if not os.path.isfile(self.__FILE_NAME):
            print("Creating the file {}, as it doesn't exist".format(self.__FILE_NAME))
            self.__create()

    def __create(self):
        with open(self.__FILE_NAME, "x"):
            pass

    def add(self, gas):
        """
        Adds a record to the database
        """

        with open(self.__FILE_NAME, "ab") as file:
            pickle.dump(gas, file, pickle.HIGHEST_PROTOCOL)

    def new(self, user, date=None):
        """
        Creates a new record
        """

        return Gas(user, date)

    def get_records(self):
        """
        Get the records from the db to an array
        """

        records = []
        with open(self.__FILE_NAME, "rb") as file:
            while True:
                try:
                    records.append(pickle.load(file))
                except EOFError:
                    break

        return records

    def clean(self):
        """
        Clear TOTALLY the content of the DB
        """

        os.remove(self.__FILE_NAME)
        self.__create()
