import Data.List (elemIndex)
import Data.Maybe (fromJust)

alphabetLower = ['a'..'z']
alphabetUpper = ['A'..'Z']

isLower :: Char -> Bool
isLower c = c `elem` alphabetLower

isUpper :: Char -> Bool
isUpper c = c `elem` alphabetUpper

ciphered :: Char -> Int -> Char
ciphered c k 
  | isLower c = newChar alphabetLower
  | isUpper c = newChar alphabetUpper
  | otherwise = c
  where newChar f  = f !! ((index f + k) `mod` length f)
        index f    = fromJust (elemIndex c f)

main :: IO()
main = do
    _   <- getLine
    str <- getLine
    factor <- getLine
    let k = read factor

    putStrLn [ ciphered c k | c <- str ]