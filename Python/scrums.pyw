#! /usr/bin/env python3

from tkinter import *
from tkinter import ttk
from random import shuffle

def getParticipants():
    persons = [ "Bo", "Chantal", "Raúl", "Vashant" ]
    shuffle(persons)

    return persons

root = Tk()
root.title("Scrum Participants")

mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
root.columnconfigure(0, weight=1)
root.rowconfigure(0, weight=1)

persons = StringVar()
ttk.Label(mainframe, textvariable=persons).grid(column=2, row=2, sticky=(W, E))

for child in mainframe.winfo_children():
    child.grid_configure(padx=5, pady=5)

persons.set("\n".join(getParticipants()))

root.mainloop()
