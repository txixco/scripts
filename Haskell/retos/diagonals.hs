import Control.Monad

type Matrix a = [[a]]

readInt :: String -> Int
readInt = read

getRowLine :: IO [Int]
getRowLine = do
    s <- getLine
    return (map readInt $ words $ s)

diagonalDifference :: Num a => Matrix a -> a
diagonalDifference xs = abs ((sum diag1) - (sum diag2))
    where diag1     = [cell i i | i <- [0..lastRow]]
          diag2     = [cell (reverse i) i | i <- [0..lastRow]]
          cell x y  = xs !! x !! y
          lastRow   = (length xs) - 1
          reverse n = abs $ lastRow - n

main :: IO ()
main = do
    n <- getLine
    mtrx <- replicateM (readInt n) getRowLine
    print (diagonalDifference mtrx)
