module Entry
( readEntry
) where

import Entry.Types

import System.IO
import Data.Time.Calendar (Day, fromGregorian)

-- turns "2012 1 1" into January 1st, 2012
getDate :: String -> Day
getDate date = dateFromList $ (map read $ words date :: [Int])
  where dateFromList [y,m,d] = fromGregorian (fromIntegral y) m d

readEntry :: FilePath -> IO Entry
readEntry path = do
  handle     <- openFile path ReadMode
  entryTitle <- hGetLine handle -- first line is title
  entryDate  <- hGetLine handle -- second line is date
  entryContents <- hGetContents handle -- rest is the content
  putStrLn $ "generating " ++ entryTitle ++ "..."
  return Entry { title = entryTitle
               , date = getDate entryDate
               , body = lines entryContents }
