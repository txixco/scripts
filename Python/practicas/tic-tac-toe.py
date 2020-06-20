#! /usr/bin/env python

board = [[0, 0, 0],
         [0, 0, 0],
         [0, 0, 0]]

def printBoard(x):
    line = " ---" * x + " "
    bars = "|   " * x + "|"

    for i in range(x):
        print(line)
        print(bars)

    print(line)

def isRow(i, j):
    piece = board[i][j]
    for k in range(3):
        if (j != k and board[i][k] != piece):
            return False

    return True

def isColumn(i, j):
    piece = board[i][j]
    for k in range(3):
        if (i != k and board[k][j] != piece):
            return False

    return True

def isDiagonal(i, j):
    if (i != j):
        return False

    piece = board[i][j]
    for k in range(3):
        if (i != k and board[k][k] != piece):
            return False

    return True

def getWinner():
    for i in range(3):
        for j in range(3):
            if (isRow(i, j) or isColumn(i, j) or isDiagonal(i, j)):
                return board[i][j]

    return 0

board = [[1, 2, 0],
	[2, 1, 0],
	[2, 1, 1]]

print("The winner is: {}".format(getWinner()))
