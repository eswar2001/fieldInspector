module Main where

import System.Environment
main :: IO ()
main = do
    x <- getArgs
    putStrLn "Test suite not yet implemented."
    let a = D "HI THERE" (length x)
    test a

test x = do
    print $ int x
    pure ()



data A = B Int String | C String

data D = D {
    name :: String
    , int :: Int
}
    deriving (Show)