#! /usr/bin/env python3

"""
Operations over the gas database
"""

import os
import pickle

from datetime import datetime

class Gas(object):
    """ Class to represent a single gas object """

    def __init__(self, user, date=None):
        self.user = user
        self.date = date if date is not None else datetime.now()

    def __repr__(self):
        return "{}|{}".format(self.user, self.date)

    def __str__(self):
        return "User: {}\nDate: {}".format(self.user, self.date)

    def __eq__(self, other):
        if isinstance(other, Gas):
            return self.user == other.user and self.date == other.date

        return NotImplemented

    def __ne__(self, other):
        are_equal = self.__eq__(other)
        if are_equal is NotImplemented:
            return NotImplemented

        return not are_equal

class GasDB(object):
    """ Class to represent the database """

    __FILE_NAME = "{}{}gas.db".format(os.path.dirname(os.path.realpath(__file__)), os.sep)
    __USERS = ["txixco", "joshurm", "ara"]

    def __init__(self, file_name=None):
        self.file_name = file_name if file_name is not None else self.__FILE_NAME
        if not os.path.isfile(self.file_name):
            print("Creating the file {}, as it doesn't exist".format(self.file_name))
            self.__create()

    def __create(self):
        with open(self.file_name, "x"):
            pass

    def add(self, gas):
        """ Adds a record to the database """

        with open(self.file_name, "ab") as file:
            pickle.dump(gas, file, pickle.HIGHEST_PROTOCOL)

        return gas

    def get_records(self):
        """ Get the records from the db to an array """

        records = []
        with open(self.file_name, "rb") as file:
            while True:
                try:
                    records.append(pickle.load(file))
                except EOFError:
                    break

        return records

    def remove(self):
        """Remove the database file"""

        os.remove(self.file_name)

    def clean(self):
        """ Clear TOTALLY the content of the DB """

        self.remove()
        self.__create()
