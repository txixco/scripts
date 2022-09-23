import Data.Char
import Data.List

bigNum = concat . lines
digits = map (fromIntegral . digitToInt)

main :: IO()
main = do
    str <- readFile "number.txt"
    print (digits . bigNum $ str)