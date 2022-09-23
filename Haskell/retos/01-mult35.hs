import qualified Data.Set as Set

deduplicate :: Ord a => [a] -> [a]
deduplicate xs = Set.elems (Set.fromList xs)

multiples :: Int -> Int -> [Int]
multiples n m = [x | x <- [1..m-1], x `mod` n == 0]

below :: Int -> [Int]
below n = deduplicate [x | x <- (multiples 3 n) ++ (multiples 5 n)]

main :: IO ()
main = print (sum (below 1000))
