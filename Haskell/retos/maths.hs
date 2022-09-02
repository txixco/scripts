module Maths where

isDivisible :: Int -> Int -> Bool
isDivisible _ 1 = True
isDivisible n m = n `mod` m == 0

--isPrime :: Int -> Bool
--isPrime n = and (isDivisible n n) True

factors :: Int -> [Int]
factors n = [x | x <- [1..n-1], isDivisible n x]

fac :: Int -> Int
fac 1 = 1
fac n = n * fac (n-1)
