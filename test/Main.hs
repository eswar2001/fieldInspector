module Main (main,test) where

data A = A {
    name :: String
    }
    deriving (Show)

main :: IO ()
main = do
    let a = A {name = "Test suite not yet implemented."}
    print a
    test a

test a = do
    let b = (name a)
    print (b <> "HI")