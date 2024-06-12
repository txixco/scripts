import Data.List (sort, group, maximumBy, sortBy)
import Data.Ord (comparing)

solve :: [Int] -> Int
solve [] = 0
solve xs = head . maximumBy (comparing length) . group . sortBy (flip compare) $ xs

main :: IO()
main = interact $ show . solve . map read . words