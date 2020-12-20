#! /usr/bin/env python3

"""
Module to manage the gas app
"""

import unittest

from datetime import datetime
from gasdb import GasDB, Gas

# The test class
class TestGasDB(unittest.TestCase):
    """Class for testing the GasDB class"""

    __MY_DATE = datetime(1973, 10, 10, 13, 15, 0)
    test_db = None

    def setUp(self):
        """Setups the test environment"""

        self.test_db = GasDB("test.db")

    def tearDown(self):
        """Clears the test environment"""

        self.test_db.remove()

    def test__repr__(self):
        """Tests the repr method for the Gas object"""

        self.assertEqual(repr(Gas("test", self.__MY_DATE)),
                         "{}|{}".format("test", self.__MY_DATE))

    def test__str__(self):
        """Tests the str method for the Gas object"""

        self.assertEqual(str(Gas("test", self.__MY_DATE)),
                         "User: {}\nDate: {}".format("test", self.__MY_DATE))

    def test__eq__(self):
        """Tests the eq method for the Gas object"""

        self.assertEqual(Gas("test", self.__MY_DATE), Gas("test", self.__MY_DATE))

    def test__eq__notimplemented(self):
        """Tests the eq method for the Gas object"""

        self.assertNotEqual(Gas("test", self.__MY_DATE), "Testing string")

    def test__ne__(self):
        """Tests the ne method for the Gas object"""

        self.assertNotEqual(Gas("test", self.__MY_DATE), Gas("test"))

    def test__ne__notimplemented(self):
        """Tests the ne method for the Gas object"""

        self.assertNotEqual(Gas("test", self.__MY_DATE), "Testing string")

    def test_add(self):
        """Tests the add method of the database"""

        original_size = len(self.test_db.get_records())
        self.test_db.add(Gas("test", self.__MY_DATE))

        records = self.test_db.get_records()
        self.assertEqual(len(records), original_size + 1)
        self.assertEqual(records[-1], Gas("test", self.__MY_DATE))

    def test_add_wo_date(self):
        """Tests the add method of the database"""

        original_size = len(self.test_db.get_records())
        new_date = self.test_db.add(Gas("test")).date

        records = self.test_db.get_records()
        self.assertEqual(len(records), original_size + 1)
        self.assertEqual(records[-1], Gas("test", new_date))

    def test_clean(self):
        """Tests the clean method of the database"""
        self.test_db.add(Gas("test"))
        self.test_db.add(Gas("test"))
        self.assertEqual(len(self.test_db.get_records()), 2)

        self.test_db.clean()
        self.assertEqual(len(self.test_db.get_records()), 0)

if __name__ == "__main__":
    unittest.main()
