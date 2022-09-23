--sqrsm :: Int -> Int
--sqrsm n = sum [ x^2 | x <- [1..n] ]
--
--smsqr :: Int -> Int
--smsqr n = (sum [1..n])^2

main :: IO()
main = do
    print("El resultado es: " ++ show ((sum [1..100])^2 - sum (map (^2) [1..100])))
