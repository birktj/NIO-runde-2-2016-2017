import Data.List

maxInT :: Integer -> Integer
maxInT t = 2^t
    -- Fint å navngi funksjoner

cost :: Integer -> Integer -> Integer
cost 0 _ = 0
cost 1 t = t
cost n t = la*4 + (n - 2*la) + cost (n - la) (t-1)
    where
        la = n `div` 2 -- last $ takeWhile (\x -> 2*x <= n) [0..]
                       -- vet faen ikkje ka eg tenkte

-- Koffor må bin-sok vaere saa jaevlig vanskelig?
lowerBound :: (Integer -> Integer) -> Integer -> Integer -> Integer -> Integer
lowerBound f l h v | h <= l    = if f l > v then l-1 else l
                   | cv < v    = lowerBound f (m+1) h v
                   | cv > v    = lowerBound f l (m-1) v
                   | otherwise = m
    where
        m = (l + h) `div` 2
        cv = f m

solve :: Integer -> Integer -> Integer
            -- Bra med litt slingringsrom
solve k t | t < 1000  = let v = lowerBound (`cost` t) 1 (min (maxInT t) k) k in v
          | otherwise = let v = lowerBound (`cost` t) 1 k k in v

main :: IO ()
main = interact ((++"\n") . show . (\(k:t:_) -> solve k t) . map read . words)
