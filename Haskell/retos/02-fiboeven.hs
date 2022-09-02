fibs :: [Integer]
fibs = 1 : 1 : zipWith (+) fibs (tail fibs)

fibsEven :: [Integer]
fibsEven = [x | x <- fibs, x `mod` 2 /= 0]

main :: IO ()
main = do
    print (takeWhile (<= 4000000) fibsEven)
    print (sum (takeWhile (<= 4000000) fibsEven))
