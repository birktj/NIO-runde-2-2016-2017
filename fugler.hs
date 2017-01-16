import qualified Data.Vector as V
import Data.Vector (Vector, (//), (!))
import Data.List
import Numeric

-- Så var det aa skjekke mattekunnskapene da
-- Positivt aa se paa Numberphile

-- Deilig at det kommer et problem som egner seg aa gjoere i haskell

-- Men strengt tatt er det litt daarlig gjort med en saa mattetung oppgave
-- Det er tross alt informatikk ol

type Matrix = Vector (Vector Double)

{-
vtranspose :: Matrix -> Matrix
vtranspose vs | V.null vs = V.empty
              | otherwise = V.snoc
-}

showMatrix :: Matrix -> String
showMatrix m = unlines . V.toList $ V.map (unwords . V.toList . V.map (\n -> showFFloat (Just 2) n "")) m

mmult :: Matrix -> Matrix -> Matrix
mmult x y = V.fromList $ map (V.fromList) l
  where
    ir = [0..V.length x-1] --range (x0,x0')
    jr = [0..V.length x-1]
    kr = [0..V.length x-1]
    l  = [[sum [(x ! i ! k) * (y ! k ! j) | k <- kr] | j <- jr] | i <- ir]

mexp :: Matrix -> Int -> Matrix
mexp m n | n == 0 = diag (V.length m)
         | n == 1 = m
         | even n = mexp (m `mmult` m) (n `div` 2)
         | otherwise = m `mmult` mexp (m `mmult` m) ((n-1) `div` 2)

diag :: Int -> Matrix
diag n = (V.replicate n V.empty) // [(x, (V.replicate n 0) // [(x, 1)]) | x <- [0..n-1]]

createMatrix :: Int -> [(Int, Int, Double)] -> Matrix
createMatrix n ps = V.map (\(i, ps) -> ps // [(i-1, 1 - V.sum ps)]) . V.zip (V.fromList [1..n]) $ foldr (\(i,j,p) m -> m // [(i-1, (m ! (i-1)) // [(j-1, p)] )]) (V.replicate n (V.replicate n 0.0)) ps

createState :: Int -> Int -> Vector Double
createState n i = V.replicate n 0 // [(i-1, 1)]

stepState :: Matrix -> Vector Double -> Vector Double
stepState m s = V.foldr (\(p, t) s' -> V.zipWith (+) s' $ V.map (*p) t) (V.map (const 0) s) (V.zip s m)

solve :: [[String]] -> String
solve ((n':e':_):xs) = unlines $ map (unwords . V.toList . V.map show . (\(s, k) -> stepState (mexp m k) s)) ss
    where
        n = read n'
        e = read e'
        ps = map (\(a:b:s:_) -> (read a, read b,read s)) $ take e xs :: [(Int, Int, Double)]
        m  = createMatrix n ps
        ss = map (\(f:k:_) -> (createState n (read f), read k)) $ drop (e+1) xs :: [(Vector Double, Int)]

main :: IO ()
main = interact (solve . map (words) . lines)
