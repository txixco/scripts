import Maths

nums = [1, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

divByAll :: Int -> [Int] -> Bool
divByAll _ []     = True
divByAll n (x:xs) = (isDivisible n x) && (divByAll n xs)

smallest :: Int -> Int
smallest n 
    | (divByAll n nums) = n
    | otherwise          = smallest (n+1)

main :: IO()
main = print (smallest 1)
