and :: [Bool] -> Bool
and []     = True
and (x:xs) = x && Main.and xs
