parseInt :: String -> Int
parseInt = read

jumps :: (Int, Int, Int, Int) -> (Int, Int)
jumps (i1, v1, i2, v2) = (j, m)
  where j = (i2 - i1) `div` (v1 - v2)
        m = (i2 - i1) `mod` (v1 - v2)
  
solution :: [Int] -> String
solution (i1:v1:i2:v2:_)
  | v1 == v2 && i1 /= i2 = "NO"
  | v1 == v2 && i1 == i2 = "YES"
  | j > 0 && m == 0      = "YES"
  | otherwise            = "NO"
  where (j, m) = jumps (i1, v1, i2, v2)

main = interact $ solution . map parseInt . words