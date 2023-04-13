parse :: String -> Int
parse = read

solution :: [Int] -> Int -> Int
solution [] _ = 0
solution _ 0  = 0
solution xs k = length ([(x, y) | (x, i) <- ys, (y, j) <- ys, i < j, (x + y) `mod` k == 0 ])
  where ys = zip xs [0..]


main :: IO()
main = do
  line <- getLine
  let [_, k] = map parse $ words line
  line <- getLine
  let list = map parse $ words line

  print $ solution list k
