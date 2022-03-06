from abc import ABC, abstractmethod
from datetime import datetime
from os import path
import sys

from bs4 import BeautifulSoup
from requests import request

class Downloader(ABC):

    def __init__(self, url: str, pictures_dir: str, sufix: str) -> None:
        super().__init__()
        self.url = url
        self.pictures_dir = pictures_dir

        today = datetime.now()
        self.img_file = path.join(self.pictures_dir, f"{today:%Y%m%d}_{sufix}.jpg")

        self.image = self.get_image()

    def get_soup(self) -> BeautifulSoup:
        """
        Gets the soup for the download page.
        """

        page = request(
            method="get",
            url=self.url
        )

        return BeautifulSoup(page.content, "html.parser")

    @abstractmethod
    def get_image(sefl) -> request:
        """Gets the image and returns it as a request."""

    def save_image(self) -> None:
        """Saves the image to disk."""

        if path.isfile(self.img_file):
            return

        if not path.isdir(self.pictures_dir):
            print(f"The path {self.pictures_dir} doesn't exist")
            sys.exit(1)

        self.image = self.get_image() if not self.image else self.image

        with open(self.img_file, "wb") as file:
            file.write(self.image.content)