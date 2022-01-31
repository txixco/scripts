#!/usr/bin/env python

'''
Calculates the time since I quit from smoking. It could be a script to
calculate date differences, but I wanted to hardcode the first time.

This script takes into account for the time zone, as I want it to be more
accurate if I move from the current time zone.
'''

from datetime import datetime

from dateutil.relativedelta import relativedelta

# The UTC quitting date :-) and now
quit_date = datetime(2012, 2, 28, 14, 20, 0)
now = datetime.now()

# Go
result = relativedelta(now, quit_date)
print(f"{result.years} years, {result.months} months, and {result.days} days")
