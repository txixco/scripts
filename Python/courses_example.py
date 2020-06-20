import time, curses

scr = curses.initscr()
scr.addstr(0, 0, "Current Time:")
scr.addstr(2, 0, "Hello World!")

while True:
    scr.addstr(0, 20, time.ctime())
    scr.refresh()
    time.sleep(1)
