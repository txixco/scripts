solve :: [Int] -> [Int]
solve [] = [0, 0]
solve (s:t:a:b:m:_:fruits) = [apples, oranges]
  where apples   = length $ filter (\x -> atHome (x+a)) $ take m fruits
        oranges  = length $ filter (\x -> atHome (x+b)) $ drop m fruits
        atHome p = (s <= p) && (p <= t)

main :: IO()
main = interact $ unlines . map show . solve . map read . words