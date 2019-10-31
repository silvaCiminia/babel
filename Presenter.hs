{-| Babel.Presenter - Performs transformations on indeces -}

module Babel.Presenter
  (inds2Abs
  ,(&>)
  ,abs2Inds
  ,(<&)
  ) where

import Babel.Common

-- | Indexing
foldInds :: [Ind] -> Integer -> AbsInd
foldInds [] _             = 0
foldInds (ind:inds) range = ind + expInd
    where expInd = range * (foldInds inds range)

cFoldInds :: [Ind] -> Integer -> Int -> [AbsInd]
cFoldInds inds range 0     = []
cFoldInds inds range grpSz = foldInds <$> splInds <*> pure range
    where splInds = inds `splitEvery` grpSz

ufoldAbs :: AbsInd -> Integer -> Integer -> [Ind]
ufoldAbs absInd range size
  | absInd == 0 = []
  | otherwise   = curInd : ufoldAbs absInd' range (size - 1)
  where curInd  = fromInteger $ absInd `quot` (range ^ size)
        absInd' = absInd `rem` (range ^ size)

-- | Exported
abs2Inds :: [AbsInd] -> Integer -> Integer -> [Ind]
abs2Inds [] _ _                  = []
abs2Inds (absInd:as) range grpSz = (reverse $ ufoldAbs absInd range adjSize) ++ abs2Inds as range grpSz
  where adjSize = grpSz - 1
absInds <& (range, grpSz) = abs2Inds absInds range grpSz

inds2Abs :: [Ind] -> Integer -> Int -> [AbsInd]
inds2Abs inds range grpSize = cFoldInds inds range grpSize
inds &> (range, grpSize) = inds2Abs inds range grpSize
