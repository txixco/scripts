import Maths

main :: IO()
main = do
    print(last (take 10001 primes))