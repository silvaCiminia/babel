# babel
A haskell module for exploring library-of-babel type collections.
https://en.wikipedia.org/wiki/The_Library_of_Babel

## Basic usage:
###Generation

Indexed representation of a random string of given length, composed of indexes from 0 to a given max index:

`indexedRep: [int] = textLength: int ~@ (maxIndex: int, rngSeed: int)`

Indexed representation of a provided string, composed of characters from the given character map:

`indexedRep: [int] = searchString: str -@ characterMap: str`

###Presentation & Interpretation

Numerical representation of an indexed Representation:

`numRep: Num = indexedRep: [int] &> (characterMapLength: int , foldingGroupSize: int)`

Indexed representation of an numerical Representation:

`indexedRep: [int] = numRep: num <$ (characterMapLength: int , foldingGroupSize: int)`

Characters ('runes') from indexed representation:

`charStr: Maybe [char] = runesFr characterMap: str indexedRep: [int]`
