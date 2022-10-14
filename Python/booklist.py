#! /usr/bin/env python3

from requests import get
from bs4 import BeautifulSoup as bs

url = "https://mpbclife.com/25-books-every-christian-should-read/"
res = get(url)
soup = bs(res.text, "lxml")
books = soup.select(".entry-content > ul > li > a")

print(f"# [25 Books Every Christian Should Read]({url})")
for book in books:
   print(f"- [ ] [{book.text}]({book.attrs['href']})")
