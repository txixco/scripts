import Maths

list :: [Int]
list = [ x * y | x <- [100..999], 
                 y <- [100..999], 
                 isPalindrome (x*y) ]

main :: IO()
main = do
    print (list)
    print ("The solution is: " ++ show (maximum list))