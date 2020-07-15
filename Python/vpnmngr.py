#!/usr/bin/env python3

'''
Connect/Disconnect to the VPN
'''

from subprocess import run
import 

# Constants
CISCO = 'C:\\ProgramData\\Microsoft\\Windows\\Start Menu\\Programs\\Cisco\\' 
        + 'Cisco AnyConnect Secure Mobility Client\\' 
        + 'Cisco AnyConnect Secure Mobility Client'

# Let's go
run(CISCO)
pyautogui.getWindowsWithTitle()