import unittest
import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from webpages import MetlifePage, ReimbursementPage, PageNotFoundException

class TestWebpage(unittest.TestCase):
    def setUp(self) -> None:
        self.webpage = ReimbursementPage()

    def tearDown(self) -> None:
        self.webpage = None

    def test_ask(self) -> None:
        self.webpage.ask()

    def test_ask_pagenotfoundexception(self) -> None:
        self.assertRaises(PageNotFoundException, self.webpage.openChrome, "https://www.google.com")

unittest.main()