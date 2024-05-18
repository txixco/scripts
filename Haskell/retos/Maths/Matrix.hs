module Maths.Matrix (
  Matrix, toMatrix, rotate90, hreflect, vreflect, distance) 
  where

import Data.List (transpose)

type Matrix a = [Row a]
type Row a = [Column a]
type Column a = a

toMatrix :: Int -> [a] -> Matrix a
toMatrix _ [] = []
toMatrix n xs = toRow (take n xs) : toMatrix n (drop n xs)

toRow :: [a] -> Row a
toRow = map toColumn

toColumn :: a -> Column a
toColumn n = n

hreflect :: Matrix a -> Matrix a
hreflect = map reverse

vreflect :: Matrix a -> Matrix a
vreflect = transpose . hreflect . transpose

rotate90 :: Matrix a -> Matrix a
rotate90 = hreflect . transpose

distance :: Matrix Int -> Matrix Int -> Int
distance m1 m2 = sum [ rdist a b | (a, b) <- zip m1 m2 ]

rdist :: Row Int -> Row Int -> Int
rdist r1 r2 = sum [ abs (a-b) | (a, b) <- zip r1 r2 ]
