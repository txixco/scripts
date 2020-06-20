#! /usr/bin/env python

import utils

def getNewList():
	l = utils.getRandomList(20, 5, 20)

	return (l, [l[0], l[-1]])

(list, newList) = getNewList()
print("List: {}\nNew List: {}".format(list, newList))
