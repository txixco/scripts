import Data.List

breakingRecords :: [Int] -> [Int]
breakingRecords xs = [best, worst]
  where best  = (length . group . map maximum . tail $ inits xs) - 1
        worst = (length . group . map minimum . tail $ inits xs) - 1

main :: IO()
main = interact $ unwords . map show . breakingRecords . map read . tail . words