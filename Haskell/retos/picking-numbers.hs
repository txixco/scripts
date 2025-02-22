import Data.List (sort, groupBy)

solve :: [Int] -> Int
solve = maximum . map length . groupBy (\a b -> abs (a-b) <= 1) . sort

main :: IO ()
main = interact $ show . solve . map read . tail . words