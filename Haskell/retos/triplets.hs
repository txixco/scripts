showInts :: (Int, Int) -> String
showInts (x, y) = show x ++ " " ++ show y

readInts :: [String] -> [Int]
readInts = map read

parse :: String -> [[Int]]
parse x = map (readInts . words) $ lines x

score :: (Num a, Ord a) => a -> a -> (a, a)
score x y
    | x > y     = (1, 0)
    | x < y     = (0, 1)
    | otherwise = (0, 0)

scores :: (Num a, Ord a) => [[a]] -> [(a, a)]
scores (xs:ys:_) = zipWith score xs ys

sum' :: [(Int, Int)] -> (Int, Int)
sum' [] = (0, 0)
sum' (x:xs) = (fst x + fst (sum' xs), snd x + snd (sum' xs))

main :: IO ()
main = interact $ \ input -> showInts $ sum' $ scores $ parse input
