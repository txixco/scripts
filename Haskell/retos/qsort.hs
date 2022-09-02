module QSort where

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = (qsort lesser) ++ [x] ++ (qsort greater)
            where
            lesser  = [a | a <- xs, a <= x]
            greater = [b | b <- xs, b > x]
