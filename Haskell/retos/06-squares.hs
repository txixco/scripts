sqrsm :: Int -> Int
sqrsm n = sum [ x^2 | x <- [1..n] ]

smsqr :: Int -> Int
smsqr n = (sum [1..n])^2

main :: IO()
main = do
    print("El resultado es: " ++ show (smsqr 100 - sqrsm 100))