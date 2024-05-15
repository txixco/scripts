import Data.Time

parse :: String -> Int
parse = read

getDate :: IO (Int, Int, Integer)
getDate = do
  line <- getLine
  let date = map parse $ words line
  return (head date, date !! 1, toInteger (date !! 2))

fine :: Integer -> Int -> Int -> Integer -> Int -> Int -> Integer
fine y1 m1 d1 y2 m2 d2
  | diff <= 0            = 0
  | y1 == y2 && m1 == m2 = 15 * diff
  | y1 == y2 && m1 > m2  = toInteger (500 * (m1 - m2))
  | y1 > y2              = 10000
  where diff  = diffDays (fromGregorian y1 m1 d1) (fromGregorian y2 m2 d2)

main :: IO()
main = do
  (d1, m1, y1) <- getDate
  (d2, m2, y2) <- getDate
  print $ fine y1 m1 d1 y2 m2 d2