parse :: String -> Int
parse = read

bonAppetite :: [Int] -> Int -> Int -> String
bonAppetite [] _ b = show b
bonAppetite xs k b 
  | b > real  = show (b - real)
  | otherwise = "Bon Appetit"
    where real  = (total - xs !! k) `div` 2
          total = sum xs

main :: IO()
main = do
  line <- getLine
  let [_, k] = map parse $ words line

  line <- getLine
  let bill = map parse $ words line

  line <- getLine
  let b = parse line

  putStrLn $ bonAppetite bill k b