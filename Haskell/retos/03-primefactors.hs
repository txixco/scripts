import Maths

main :: IO ()
main = do
    print (primeFactors 600851475143)
    print ("The solution is: " ++ show (maximum (primeFactors 600851475143)))