#!/usr/bin/env python3

import csv
import re

from typing import List

def process(list: List[str], search: str, subs: int):
    """ Process the list of items """

    retList: List[str] = []

    for i, item in enumerate(list):
        if search in item:
            retList.append(list[i-subs])

    return retList


def main(fileName: str):
    messages: List[str] = []
    foundList: List[str] = []
    ids: List[str] = []

    with open(fileName) as csv_data:
        csv_reader = csv.reader(csv_data)

        for row in csv_reader:
            messages.append(row[-1])

    foundList = process(messages, "The account has not been successfully adjusted", 2)
    print(foundList)

if __name__ == "__main__":
    main('Job_EC-Small-Dollar-Write-Off-Dispatcher_Production HC - Dunning Letters-logs.csv')