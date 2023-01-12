import Data.List (union)

nums = union [3, 6..999] [5, 10..999]

solve :: Int
solve = sum nums

main :: IO ()
main = print solve
