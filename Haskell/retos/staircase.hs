staircase :: Int -> Int -> [String]
staircase 0 _ = []
staircase n m = (staircase (n-1) m) ++ [spaces ++ replicate n '#']
    where spaces = replicate (m - n) ' '

main = do
    line <- getLine
    let len = (read line :: Int)
    putStrLn (unlines $ staircase len len)
