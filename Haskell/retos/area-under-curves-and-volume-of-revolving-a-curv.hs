import Text.Printf (printf)

between :: Int -> Int -> [Double] -> [Double]
between _ _ [] = []
between a b l = take (b-a+1) $ drop a l

expr :: [Int] -> [Int] -> Int -> Double
expr as bs x = sum $ zipWith (\a b -> fromIntegral $ a * b^x) as bs

-- This function should return a list [area, volume].
solve :: Int -> Int -> [Int] -> [Int] -> [Double]
solve l r as bs = [area]
  where
    area = sum $ map func [l..r]
    func = expr as bs

--Input/Output.
main :: IO ()
main = getContents >>= mapM_ (printf "%.1f\n"). (\[a, b, [l, r]] -> solve l r a b). map (map read. words). lines