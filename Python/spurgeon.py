#!/usr/bin/env python

from datetime import datetime
import webbrowser

months = [ 'Enero',
           'Febrero',
           'Marzo',
           'Abril',
           'Mayo',
           'Junio',
           'Julio',
           'Agosto',
           'Septiembre',
           'Octubre',
           'Noviembre',
           'Diciembre']

today = datetime.today()
day = today.day
month = months[today.month-1]

url = 'http://www.spurgeon.com.mx/chequera/{}{}.html'.format(day, month)
print(url)

webbrowser.open(url)
