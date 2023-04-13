import Data.List

parse :: String -> Int
parse = read

sequences :: [a] -> [[a]]
sequences [] = []
sequences xs = myInits xs ++ sequences (tail xs)
  where myInits xs = tail $ inits xs

sequencesOf :: [[a]] -> Int -> [[a]]
sequencesOf [] _ = []
sequencesOf _ 0  = []
sequencesOf xs n = filter (\ys -> length ys == n) xs

solution :: [Int] -> Int -> Int -> Int
solution [] _ _ = 0
solution xs d m = length (filter (\ys -> sum ys == d) (sequencesOf (sequences xs) m))

main :: IO()
main = do
  _ <- getLine
  line <- getLine
  let list = map parse $ words line
  line <- getLine
  let [d, m] = map parse $ words line

  print $ solution list d m