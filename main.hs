{-# LANGUAGE OverloadedStrings #-}

import System.IO
import System.Directory

import Entry
import Entry.Types
import Entry.Render

-- the path where the entries are stored
inputPath :: FilePath
inputPath = "input/"

-- the path to output the completed html documents
outputPath :: FilePath
outputPath = "output/"

generateEntries :: FilePath -> IO [Entry]
generateEntries path = mapM (readEntry . (++) inputPath) . filter (`notElem` [".",".."]) =<< getDirectoryContents path

saveEntries :: [Entry] -> IO ()
saveEntries [] = return ()
saveEntries (x:xs) = do
  -- provide some information about what's happening
  putStrLn $ ("writing " ++ (title x) ++ ".html...")
  writeFile (outputPath ++ (title x) ++ ".html") (renderEntry x)
  saveEntries xs

main :: IO ()
main = do
  -- get a list of files
  entryList <- generateEntries inputPath
  -- get rid of all files except the css
  mapM_ (removeFile . (++) outputPath) . filter (`notElem` [".","..","style.css"]) =<< getDirectoryContents outputPath
  -- save all the entries
  saveEntries entryList
  -- we're done
  putStrLn "done"
