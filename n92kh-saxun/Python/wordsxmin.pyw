#!/usr/bin/env python3


from tkinter import *
import time, winutils, wpm, re

# Functions
def onUpdate(w, t) :
    numberPtrn = re.compile("^[0-9]+$")
    timePtrn = re.compile("^[0-9]+:[0-9][0-9]$")
    
    if (numberPtrn.match(w.get())) and (timePtrn.match(t.get())) :
        words = int(w.get())
        time = t.get().split(":")
        global result
        result.set('Words per minute = ' \
                    + '{:.2f}'.format(wpm.calculate(words, time)))

# Defining the window
root = winutils.getRoot("Words per minute", "300x100")
root.resizable(width=False, height=False)
winutils.center(root)

result = StringVar()

words = StringVar()
words.trace("w", lambda name, index, mode, words=words: onUpdate(words, time))

time = StringVar()
time.trace("w", lambda name, index, mode, time=time: onUpdate(words, time))

Label(root, text="Words", pady=5).grid(row=0, sticky="w")
Label(root, text="Time").grid(row=1, sticky="w")
Label(root, textvariable=result, pady=20).grid(row=4, columnspan=2, sticky="w")

txtWords = Entry(root, textvariable=words)
txtWords.grid(row=0, column=1)
txtWords.focus()

txtTime = Entry(root, textvariable=time)
txtTime.grid(row=1, column=1)

mainloop()
