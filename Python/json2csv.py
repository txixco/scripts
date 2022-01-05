import json, csv

from types import SimpleNamespace
from typing import Dict

def readJsonList():
    with open("jsons.lst") as f:
        return f.readlines()

def main():
    jsonList = readJsonList()
    columnNames = json.loads(jsonList[0]).keys()

    with open("items.csv", "w") as file:
        csv_writer = csv.writer(file)
        csv_writer.writerow(columnNames)
        rows = [ json.loads(item).values() for item in jsonList ]
        csv_writer.writerows(rows)

if __name__ == "__main__":
    main()