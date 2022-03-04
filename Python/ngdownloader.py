#!/usr/bin/env python3

"""
Gets the photo of the day from National Geographic and sets it as wallpaper.
"""

import sys
from datetime import datetime
from os import name, path, system
from shutil import copyfile

from bs4 import BeautifulSoup
from requests import request

# Options
GET_DESCRIPTION = "yes"
PICTURES_DIR = "/home/txixco/fondos/NG"

# Functions


def get_image() -> request:
    """
    Gets the image and returns it as a request.
    """

    print("Downloading the image")
    page = request(
        method="get",
        url="http://photography.nationalgeographic.com/photography/photo-of-the-day"
    )

    soup = BeautifulSoup(page.content, "html.parser")
    url = soup.find(property="og:image").get("content")

    return request(method="get", url=url)


def set_wallpaper(img_file: str):
    """
    Sets the wallpaper
    """
    print("Setting image as wallpaper")

    if name == "nt":
        dest_file = path.join(path.dirname(img_file), "ng-potd.jpg")
        copyfile(img_file, dest_file)

        return

#    gconftool-2 -t string -s /desktop/gnome/background/picture_filename $IMAGE_FILE

    commands = [
        "export DISPLAY=:0.0",
        # Gnome
        f"gsettings set org.gnome.desktop.background picture-uri file:///{img_file}",
        # i3
        f"nitrogen {img_file}",
    ]

    print("; ".join(commands))
    system("; ".join(commands))


def main():
    """
    Main function.
    """

    print("Setting the NGEO Wallpaper")

    today = datetime.now()
    img_file = path.join(PICTURES_DIR, f"{today:%Y%m%d}_ngeo.jpg")
    image = get_image()

    if not path.isdir(PICTURES_DIR):
        print(f"The path {PICTURES_DIR} doesn't exist")
        sys.exit(1)

    with open(img_file, "wb") as file:
        file.write(image.content)

    set_wallpaper(img_file)


if __name__ == "__main__":
    main()
