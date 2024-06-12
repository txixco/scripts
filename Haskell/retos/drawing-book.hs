import Data.List
import Data.Maybe

type Pair = (Int, Int)

getInt :: IO Int
getInt = do
  line <- getLine
  let num = read line :: Int
  return num

pages :: Int -> [Pair]
pages n = [ (x, x+1) | x <- xs, even x ]
  where xs    = [0..n]

pageIndex :: Int -> [Pair] -> Int
pageIndex pg ps
  | even pg   = fromJust $ elemIndex (pg, pg+1) ps
  | otherwise = fromJust $ elemIndex (pg-1, pg) ps

solution :: Int -> Int -> Int
solution pgs pg = min idx xdi
  where idx = pageIndex pg (pages pgs)
        xdi = length (pages pgs) - idx - 1
        

main :: IO()
main = do
  totalPages <- getInt
  page       <- getInt
  print $ solution totalPages page