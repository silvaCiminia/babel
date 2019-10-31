{-| Babel.Librarian - Converts a list of indeces into a set of runes into the list of corresponding runes -}

module Babel.Librarian
  (runesFr
  ,runeMap32
  ,runeMap64
  ) where

import Babel.Common

import Data.List

-- | Text Generation
runeFr :: RuneMap -> Ind -> Maybe Rune
runeFr runeMap ind = find (\rune -> elemIndex rune runeMap == Just (fromInteger ind)) runeMap

runesFr :: RuneMap -> [Ind] -> Maybe [Rune]
runesFr runeMap inds = consolidate $ (runeFr runeMap) <$> inds
