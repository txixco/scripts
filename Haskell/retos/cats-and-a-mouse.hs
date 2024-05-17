winner :: Int -> Int -> Int -> String
winner x y z
  | distA < distB = "Cat A"
  | distA > distB = "Cat B"
  | otherwise     = "Mouse C"
  where distA = abs (z-x)
        distB = abs (z-y)

solve :: [Int] -> [String]
solve (n:x:y:z:xs) = winner x y z : solve ((n-1):xs)
solve _  = []

main :: IO()
main = interact $ unlines . solve . map read . words