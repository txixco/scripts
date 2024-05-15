import Data.List (sort, elemIndex)
import Data.Maybe (fromJust)

putTransmissor :: [Int] -> Int -> Int
putTransmissor _ 0  = 0
putTransmissor [] _ = 0
putTransmissor xs n
  | elem n xs = n
  | otherwise = putTransmissor xs (n-1)

remainder :: [Int] -> Int -> [Int]
remainder [x] _ = []
remainder _ 0   = []
remainder [] _  = []
remainder xs n
  | elem n xs = drop (fromJust (elemIndex n xs)) xs
  | otherwise = drop (n+1) (remainder xs n)
  
hackerlandRadioTransmitters :: [Int] -> Int -> [Int]
hackerlandRadioTransmitters [] _ = []
hackerlandRadioTransmitters (x:xs) k = (putTransmissor xs x+k) : (hackerlandRadioTransmitters rem k)
  where rem = remainder xs (x+2*k+1)

solve :: [Int] -> [Int]
solve (_:k:xs) = hackerlandRadioTransmitters (sort xs) k

main :: IO()
main = interact $ show . solve . map read . words