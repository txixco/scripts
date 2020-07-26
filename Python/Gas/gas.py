#! /usr/bin/env python3

"""
Module to manage the gas app
"""

from datetime import datetime
import gasdb

def main():
    """
    Main execution flow
    """

    gas_db = gasdb.GasDB()
    gas_db.clean()

    gas_db.add(gas_db.new("txixco", datetime(1973, 10, 10, 13, 15, 00)))
    gas_db.add(gas_db.new("joshurm"))

    records = "\n\n".join(str(s) for s in gas_db.get_records())
    print(records)

main()
