parseInt :: String -> Int
parseInt = read

myRound :: Int -> Int
myRound n
  | n >= 38 && diff < 3 = next
  | otherwise           = n
  where next = n + 5 - (n `mod` 5)
        diff = next - n

main = interact $ unlines . map (show . myRound . parseInt) . tail . words