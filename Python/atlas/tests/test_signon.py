import unittest
import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from signon import SignNowPage


class TestSignon(unittest.TestCase):
    def setUp(self) -> None:
        self.signow = SignNowPage("fjrueda@west.com")

        return super().setUp()

    def test_signon(self) -> None:
        self.signow.signon()
        self.assertTrue(True)

unittest.main()