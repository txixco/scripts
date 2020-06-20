#!/usr/bin/env python

import sys, requests, tkinter
from lxml import html
from datetime import datetime
from tkinter import messagebox

def getVerse(day, month):
    url = "http://www.spurgeon.com.mx/chequera/{}{}.html".format(day, month)

    content = requests.get(url).text
    root = html.fromstring(content)

    return root.xpath("//i")[0].text.strip()

months = [ "Enero",
           "Febrero",
           "Marzo",
           "Abril",
           "Mayo",
           "Junio",
           "Julio",
           "Agosto",
           "Septiembre",
           "Octubre",
           "Noviembre",
           "Diciembre"]

today = datetime.today()
day = today.day
month = months[today.month-1]
year = today.year

# hide main window
root = tkinter.Tk()
root.withdraw()

# Define the dialog and go
verse = getVerse(today.day, month)
title = "Cheque del {} de {} de {}".format(day, month.lower(), year)
messagebox.showinfo(title, verse)
