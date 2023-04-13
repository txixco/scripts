import Data.List (group, sort)

parse :: String -> Int
parse = read

solution :: [Int] -> [Int]
solution xs = [length ys `div` 2 | ys <- groups, length ys > 1]
  where groups = group $ sort xs

main :: IO()
main = do
  _ <- getLine
  line <- getLine
  let input = map parse $ words line
  print $ sum $ solution input