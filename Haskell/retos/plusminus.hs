type Solution = [Float]

parse :: String -> Int
parse = read

positives :: [Int] -> Int
positives xs = length [n | n <- xs, n > 0]

negatives :: [Int] -> Int
negatives xs = length [n | n <- xs, n < 0]

zeroes :: [Int] -> Int
zeroes xs = length [n | n <- xs, n == 0]

solution :: [Int] -> Solution
solution xs = [prop positives, prop negatives, prop zeroes]
    where prop f = fromIntegral (f xs) / fromIntegral total
          total  = length xs

main = interact $ unlines . map show . solution . map parse . tail . words
