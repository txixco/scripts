parseInt :: String -> Int
parseInt = read

divisor :: Int -> Int -> Bool
divisor n m = n `mod` m == 0

factor :: Int -> [Int] -> Bool
factor _ [] = True
factor n (x:xs) = divisor n x && factor n xs

factors :: [Int] -> [Int] -> [Int]
factors xs ys = [n | n <- xs, factor n ys]

antiFactor :: Int -> [Int] -> Bool
antiFactor _ [] = True
antiFactor n (x:xs) = divisor x n && antiFactor n xs

getNums :: String -> [Int]
getNums = map parseInt . words

getLists :: IO([Int], [Int])
getLists = do
  _      <- getLine
  input1 <- getLine
  input2 <- getLine

  let list1 = getNums input1
  let list2 = getNums input2

  return (list1, list2)

main :: IO()
main = do
  (list1, list2) <- getLists
  let facts1 = factors [maximum list1..minimum list2] list1
  let facts2 = [n | n <- facts1, antiFactor n list2]
  
  -- putStrLn $ unwords $ map show facts2
  print $ length facts2