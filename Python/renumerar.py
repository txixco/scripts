#!/usr/bin/env python3
 
'''
Renum the files in a directory
'''
 
import sys, argparse

from glob import glob
from os import rename

def getArgs():
    parser = argparse.ArgumentParser("Renumerate, given an extension, the files in the current directory")
    parser.add_argument("-s", "--string", dest="string", required=True, help="the prefix for the file names")
    parser.add_argument("-e", "--extension", dest="ext", required=True, help="the extension to renumerate")
    parser.add_argument("-d", "--digits", type=int, dest="digits", default=0, help="the number of digits for the order number")
    parser.add_argument("-n", dest="nel", action="store_true", default=False, help="indicates if the renaming is NOT in effect")

    return parser.parse_args()

def main():
    args = getArgs()
    string = args.string
    ext = args.ext
    nel = args.nel
    
    files = glob("*." + ext)
    files.sort()
    digits = args.digits if args.digits>0 else len(str(len(files)))

    if (len(files) > int("9" * (10 ** digits))) :
        print("The files quantity is more than the alowed by the number of digits")
        exit(2)

    num = 0
    i = 1
    
    for i, file in enumerate(files) :
        newFile = f"{string}-{i+1:0{digits}}.{ext.lower()}"
        print(f"Renaming {file} to {newFile}")
        if (not nel):
            rename(file, newFile)

if __name__ == "__main__":
    main()