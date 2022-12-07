#! /usr/bin/env python3

import pendulum
from tabulate import tabulate

def main() -> None:
    ct = "America/Mexico_City"
    cet = "Europe/Madrid"
    et = "America/New_York"


    mex = pendulum.now(ct)
    nyc = mex.in_timezone(et)
    mad = mex.in_timezone(cet)
    
    table = [
        ["CDMX", mex.format("LT", "es")], 
        ["New York", nyc.format("LT", "es")], 
        ["Madrid", mad.format("LT", "es")]
    ]

    print(tabulate(table))


if __name__ == "__main__":
    main()
