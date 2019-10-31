{-| Babel.Oracle - Calculates a raw list of inds into a runeMap, using a psrng or a search string -}

module Babel.Oracle
  (rIndsFr
  ,(~@)
  ,indsIn
  ,(-@)
  ,sr32
  ,sr64
  ) where

import Babel.Common

import System.Random
import Data.List
import Control.Monad.State

-- | Randomization
randIn :: RandomGen g => Integer -> State g Ind
randIn upperLimit = state $ randomR (0, upperLimit-1)

rListOf :: RandomGen g => Int -> Integer -> State g [Ind]
rListOf len range = replicateM len (randIn range)

rIndsFr :: Int -> Integer -> Int -> [Ind]
-- ^Generate a list of random indeces within the range of (0..r) of len l using starting seed g
rIndsFr len range gen = fst $ runState (rListOf len range) (mkStdGen gen)
len ~@ (range, gen)   = rIndsFr len range gen

-- | Search
indsIn :: [Rune] -> RuneMap -> [Ind]
-- ^Generate a list of indeces into the runeMap from a list of runes
indsIn runes runeMap = fmap toInteger $ (report . consolidate) $ (elemIndex <$> runes) `ap` (return runeMap)
runes -@ runeMap = indsIn runes runeMap

sr32 seq = indsIn seq runeMap32
sr64 seq = indsIn seq runeMap64
