#!/usr/bin/env python3

"""Gets the photo of the day from National Geographic and sets it as wallpaper"""

import sys

from os import name
from requests import request, Response
from downloader import Downloader
from myutils import set_wallpaper

# The class
class NASADownloader(Downloader):
    """Class to download the image of the day from National Geographic"""

    def get_image(self) -> Response:
        """Gets the image and returns it as a response"""

        soup = self.get_soup()
        img_url = soup.findAll("enclosure")[0]["url"]

        return request(method="get", url=img_url)

# Allons-y!
def main():
    """Main function"""

    downloader = NASADownloader(
        url="https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss", 
        pictures_dir=(r"C:\Users\frueda\Data\Pictures\Fondos\NASA" if name == "nt" else "/home/txixco/fondos/NASA"),
        sufix="nasa"
    )

    downloader.save_image()

    set_wallpaper(downloader.img_file)

if __name__ == "__main__":
    main()