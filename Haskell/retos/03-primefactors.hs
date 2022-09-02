import Maths

primeFactors :: Int -> [Int]
primeFactors n = [x | x <- factors n, ]
main :: IO ()
main = go
    
