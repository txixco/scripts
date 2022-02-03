#!/usr/bin/env python3

"""
Gets the Spurgeon's sermons index and convert it to md.
"""

from bs4 import BeautifulSoup
from requests import request


def main():
    """
    Main function
    """

    BASE_URL = "http://www.spurgeon.com.mx/"

    index_page = request(
        method="get", url="http://www.spurgeon.com.mx/indiceCNPS.html")
    soup = BeautifulSoup(index_page.content, "html.parser")
    index = soup.find(class_="Section1").table

    with open("sermons.md", "w", encoding="utf-8") as file:
        for i, row in enumerate(index.find_all("tr")):
            if i > 0:
                try:
                    cells = row.find_all("td")
                    sermon = int(cells[0].find("span").string)
                except ValueError:
                    sermon = 0
                except Exception as ex:
                    raise ex

                links = row.find_all("a")
                checked = " " if sermon > 195 else "X"
                md_str = f'- [{checked}] [{links[0].string}]({BASE_URL}{links[0].get("href")})'
                md_str += f' [PDF]({BASE_URL}{links[1].get("href")})'

                file.write(f"{md_str}\n")


if __name__ == "__main__":
    main()
