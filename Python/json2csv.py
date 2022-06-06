#! /usr/bin/env python3

"""
Takes a list of JSON items from a file, and exports them to a CSV file.
"""

import csv
import json


def read_json_list():
    """
    Read the list of JSON items from the file.
    """

    with open("jsons.lst") as file:
        return file.readlines()


def main():
    """
    Convert a list of JSON items to CSV.
    """

    json_list = read_json_list()
    column_names = json.loads(json_list[0]).keys()

    with open("items.csv", "w") as file:
        csv_writer = csv.writer(file)
        csv_writer.writerow(column_names)
        rows = [json.loads(item).values() for item in json_list]
        csv_writer.writerows(rows)


if __name__ == "__main__":
    main()
