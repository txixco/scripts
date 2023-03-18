import Data.List (group, sort)

parse :: String -> Int
parse = read

groups :: [Int] -> [[Int]]
groups = group . sort

solution :: [[Int]] -> [Int]
solution xs = [length ys `div` 2 | ys <- xs, length ys > 1]

main :: IO()
main = do
  _ <- getLine
  line <- getLine
  let input = map parse $ words line
  print $ sum $ solution $ groups input