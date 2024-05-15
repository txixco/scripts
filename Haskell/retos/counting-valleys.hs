import Data.List (groupBy)
import Data.Time.Clock.TAI (taiClock)

delta :: Char -> Int
delta 'U' = 1
delta 'D' = -1
delta _   = 0

solve :: String -> Int
solve = 
    length . 
    filter (all (<0)) . 
    groupBy (\x y -> x /= 0 && y /= 0) . 
    scanl (+) 0 .
    map delta

main :: IO()
main = interact $ show . solve . last . words