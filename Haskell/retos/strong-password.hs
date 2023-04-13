numbers = "0123456789"
lowerCase = "abcdefghijklmnopqrstuvwxyz"
upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
specialChars = "!@#$%^&*()-+"

minChars :: String -> Int
minChars x = max len (sum [has numbers, has lowerCase, has upperCase, has specialChars])
  where len                  = 6 - length x
        has s 
          | any (`elem` s) x = 0
          | otherwise        = 1

main :: IO()
main = interact $ show . minChars . last . lines