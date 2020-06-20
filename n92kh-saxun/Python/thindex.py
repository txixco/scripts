#! /usr/bin/env python3

import sys, requests
from lxml import html
from tkinter import Tk

# Constants
MODULES = '//div[contains(@class, "trail-module-item")]'
UNITS = '//ul[contains(@class, "module-units-list")]//li//a'
ITEMS = '//ul[contains(@class, "trailhead-child-items")]//li//a'

# Functions
def printModule() :
    for module in root.xpath(MODULES) :
        url = 'https://trailhead.salesforce.com' \
               + module.xpath('.//h3//a//@href')[0]
 
        title = module.xpath('.//h3//a//text()')[0]

        printHeading(url, title, 3)
        printElements(module, '.' + UNITS, 2)
        printElements(module, '.' + ITEMS, 2)

def printElements(root, xpath, level=1) :
    for item in root.xpath(xpath) :
        url = 'https://trailhead.salesforce.com' \
                + item.xpath('.//@href')[0]

        for div in item.xpath('.//div[not(@class)]') :
            printItem(url, div.text.strip(), level)

def printHeading(url, text, level=1) :
    print('{} [[{}][{}]]'.format('*' * level, url, text))

def printItem(url, text, level=1) :
    print('{}- [[{}][{}]]'.format('  ' * level, url, text))

# Let's go
if __name__ == '__main__' :
    if (len(sys.argv) > 1) :
        url = sys.argv[1]
    else :
        tk = Tk()
        tk.withdraw()
        url = tk.clipboard_get()

    content = requests.get(url).text
    root = html.fromstring(content)

    printHeading(root.xpath('//meta[@property="og:url"]/@content')[0],
            root.xpath('//meta[@property="og:title"]/@content')[0],
            2)

    if (root.xpath(MODULES)) :
        printModule()
    else :
        printElements(root, UNITS)
        printElements(root, ITEMS)
