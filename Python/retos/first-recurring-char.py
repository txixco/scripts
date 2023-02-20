#! /usr/bin/env python

from collections import Counter

lst: list = [2, 5, 5, 2, 3, 5, 1, 2, 4]

def solution1(lst: list) -> None: # O(n^2)
    for i, n in enumerate(lst): # O(n)
        if n in lst[i+1:]:   # O(n)
            print(n)
            break

def solution2(lst: list) -> None: # O(n)
    items: dict = {}
    for n in lst: # O(n)
        if n in items: # O(1)
            print(n)
            break

        items[n] = True

def solution3(lst: list) -> None: # O(n)
    items: dict = Counter(lst) # O(n) ?
    for n in lst: # O(n)
        if items[n] > 1:
            print(n)
            break

solution1(lst) # More O, returns 2 (for me, the correct answer)
solution2(lst) # Less O, returns 5 (depends on the interviewer)
solution3(lst) # Less O, returns 2

# For memory complexity, solution2 and solution3 are worst