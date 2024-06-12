isDivisible :: Integral a => a -> a -> Bool
isDivisible _ 0 = False
isDivisible 0 _ = True
isDivisible n m = (mod n m) == 0

isJlnLeap :: Integral a => a -> Bool
isJlnLeap n = isDivisible n 4

isGregLeap :: Integral a => a -> Bool
isGregLeap n = (isDivisible n 400) || ((isDivisible n 4) && (not (isDivisible n 100)))

julianDay :: (Show a, Integral a) => a -> String
julianDay n = day ++ ".09." ++ (show n)
  where day = if isJlnLeap n then "12" else "13"

gregorianDay :: (Show a, Integral a) => a -> String
gregorianDay n = day ++ ".09." ++ (show n)
  where day = if isGregLeap n then "12" else "13"

programmerDay :: (Show a, Integral a) => a -> String
programmerDay n
  | n == 1918              = "26.09.1918"
  | n >= 1700 && n <= 1917 = julianDay n
  | n >= 1919 && n <= 2700 = gregorianDay n
  | otherwise              = error "Year is out of range"

main :: IO()
main = do
  input <- getLine
  let year = read input :: Int
  putStrLn (programmerDay year)
