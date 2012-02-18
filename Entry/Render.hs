{-# LANGUAGE OverloadedStrings #-}

module Entry.Render
( renderEntry
) where

import qualified Entry.Types as E

import Data.Time.Calendar (showGregorian)

import Text.Blaze ((!))
import Text.Blaze.Renderer.Pretty
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

renderEntry :: E.Entry -> String
renderEntry entry = renderHtml $
  H.html $ do
    H.head $ do
      H.link ! A.rel "stylesheet" ! A.type_ "text/css" ! A.href "style.css"
      H.title entryTitle
      H.body $ do
        H.div ! A.id "container" $ do
        H.h1 entryTitle
        H.h3 entryDate
        -- we need to go through each individual entry and convert it
        -- before adding a <p> tag
        mapM_ (H.p . H.toHtml) $ E.body entry
  where entryTitle = H.toHtml $ E.title entry
        entryDate  = H.toHtml $ showGregorian $ E.date entry

