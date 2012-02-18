module Entry.Types
( Entry(..)
) where

import Data.Time.Calendar

data Entry =
  Entry { date     :: Day
        , title    :: String
        , body     :: [String] } deriving (Show)
