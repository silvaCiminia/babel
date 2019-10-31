{-| Babel.Common - Common types and functions -}

module Babel.Common
  (Ind
  ,AbsInd
  ,Rune
  ,RuneMap
  ,runeMap32
  ,runeMap64
  ,splitEvery
  ,consolidate
  ,report
  ) where

-- | Type Synonyms
type Ind     = Integer -- Physical index into collection
type AbsInd  = Integer -- Abstract index into keyspace
type Rune    = Char
type RuneMap = [Rune]

-- | Standard Maps
runeMap32 :: [Rune]
runeMap32 = "abcdefghijklmnopqrstuvwxyz,.?'\" "

runeMap64 :: [Rune]
runeMap64 = "abcdefghijklmnopqrstuvwxyz,.?'\" 0123456789!<>@#$%^&*()-+=;:~_|/\\"

-- | Common Functions
splitEvery :: [a] -> Int -> [[a]]
splitEvery [] _ = []
splitEvery ls n = section : splitEvery ls' n
    where (section,ls') = splitAt n ls

consolidate :: [Maybe a] -> Maybe [a]
consolidate []          = Nothing
consolidate (Nothing:_) = Nothing
consolidate (Just x:[]) = Just[x]
consolidate (x:xs)      = (:) <$> x <*> (consolidate xs)

report ::  Maybe [a] -> [a]
report Nothing  = []
report (Just x) = x
