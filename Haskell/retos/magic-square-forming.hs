import Maths.Matrix (Matrix, toMatrix, vreflect, hreflect, rotate90, distance)
import Data.List (transpose)

pp :: Matrix Int -> IO()
pp = putStrLn . unlines . map (unwords . map show)

magic :: Matrix Int
magic = [[8, 1, 6],
         [3, 5, 7],
         [4, 9, 2]]

allMagics :: [Matrix Int]
allMagics = am1 ++ am2
  where am1 = take 4 $ iterate rotate90 magic
        am2 = take 4 $ iterate rotate90 $ transpose magic

solve :: [Int] -> Int
solve xs = minimum [ distance (toMatrix 3 xs) m | m <- allMagics ]

main :: IO()
main = interact $ show . solve . map read . words