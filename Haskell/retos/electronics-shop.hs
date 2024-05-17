solve :: [Int] -> Int
solve (b:n:_:rest) = maxPrices $ inBudget b keybs drivs
  where keybs = take n rest
        drivs = drop n rest

inBudget :: Int -> [Int] -> [Int] -> [Int]
inBudget b xs ys = filter (<= b) $ sumcp xs ys
  where sumcp xs ys = [x + y | x <- xs, y <- ys]

maxPrices :: [Int] -> Int
maxPrices [] = -1
maxPrices xs = maximum xs 

main :: IO()
main = interact $ show . solve . map read . words