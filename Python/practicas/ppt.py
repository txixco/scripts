#! /usr/bin/env python

import random

possibilities = [ "PP","PT","PL","LL","LP","LT","TT","TL","TP" ]
players = [ "Tú", "Yo" ]
objects = { "P" : "Piedra",
            "L" : "Papel",
            "T" : "Tijera" }

while True :
    player = input("¿(P)iedra, pape(L) o (T)ijeras? ").upper()
    myShot = random.choice( ['P', 'L', 'T'] )

    print("Yo elijo {}".format(objects[myShot]))

    try :
        winner = possibilities.index(player + myShot) % 3

        if (winner == 0) :
            print("Hay un empate")
        else :
            print("Y el ganador es... ¡{}!".format(players[winner-1]))

    except ValueError :
        print("Tu elección no es válida")

    if ((input("¿Deseas jugar de nuevo? (S/N)") or "s").lower() != "s") :
        break
