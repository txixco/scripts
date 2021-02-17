#! /usr/bin/env python

coins = [50, 20, 10, 5]

def change(left, i, comb, add):
    if add: comb.append(add)
    if left == 0 or (i+1) == len(coins):
        if (i+1) == len(coins) and left > 0:
           if left % coins[i]:
               return 0
           comb.append( (left/coins[i], coins[i]) )
           i += 1
        while i < len(coins):
            comb.append( (0, coins[i]) )
            i += 1
        print(" ".join("%d*%d" % (n,c) for (n,c) in comb))
        return 1
    cur = coins[i]
    return sum(change(left-x*cur, i+1, comb[:], (x,cur)) for x in range(0, int(left/cur)+1))

print('Number of combinations: {}'.format(change(100, 0, [], None)))
