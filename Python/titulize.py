#!/usr/bin/env python3

"""
Rename the file passed as argument, so it is in lower cases and has '_' instead of some symbols
"""

import os
from re import sub
from sys import argv

# Constants
DASH_REGEX = "[\\s\\-\\.]+"

# Alons-y!


def main():
    """
    Main function
    """

    for file in argv[1:]:
        (old, ext) = os.path.splitext(file)
        new = sub(pattern=DASH_REGEX, repl="_", string=old)
        new = new.lower()
        new = f"{new}{ext}"

        print(f"{file} -> {new}")

        try:
            os.rename(file, new)
        except OSError as ose:
            print(f"Couldn't rename {file} to {new}: {ose}")


if __name__ == "__main__":
    main()
