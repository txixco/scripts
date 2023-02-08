import Data.Time

parse :: String -> UTCTime
parse = parseTimeOrError True defaultTimeLocale "%I:%M:%S%p"

format :: UTCTime -> String
format = formatTime defaultTimeLocale "%H:%M:%S" 

main = interact $ format . parse