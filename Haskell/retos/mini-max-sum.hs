import Data.List (sort, intercalate)

parse :: String -> Int
parse = read

toString :: (Int, Int) -> String
toString (min, max) = intercalate " " (map show [ min, max])

solution :: [Int] -> (Int, Int)
solution xs = (minSum, maxSum)
  where minSum = sum (take 4 (sort xs)) 
        maxSum = sum (take 4 (reverse $ sort xs))

main :: IO ()
main = interact $ toString . solution . map parse . words
