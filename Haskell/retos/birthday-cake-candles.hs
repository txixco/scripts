import Data.List (sort, group)

parse :: String -> Int
parse = read

main :: IO ()
main = interact $ show . length . maximum . group . sort . map parse . tail .words
