#! /usr/bin/env python

import requests
from bs4 import BeautifulSoup

def printHeadings():
	for story_heading in soup.find_all("h2"):
		print(story_heading.text.replace("\n", " ").strip())

def writeHeadings(fn):
	with open(fn, "w") as openFile:
		for story_heading in soup.find_all("h2"):
			openFile.write(story_heading.text.replace("\n", " ").strip() + "\n")

url = 'http://www.nytimes.com/'
r = requests.get(url)
soup = BeautifulSoup(r.text, features="lxml")

fileName = input("Dime el nombre de archivo: ")
if (fileName == ""):
	printHeadings()
else:
	writeHeadings(fileName)

