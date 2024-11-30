-- For making it measurable with the default GHC backend of Agda.
module MAlonzoIO where

open import Agda.Builtin.IO
open import Agda.Builtin.String
open import Agda.Builtin.Unit

postulate
  getLine     : IO String
  putStr      : String → IO ⊤
  putStrLn    : String → IO ⊤

{-# FOREIGN GHC import qualified Data.Text    as T   #-}
{-# FOREIGN GHC import qualified Data.Text.IO as TIO #-}
{-# FOREIGN GHC import qualified System.IO           #-}
{-# FOREIGN GHC import qualified Control.Exception   #-}

{-# COMPILE GHC getLine    = TIO.getLine               #-}
{-# COMPILE GHC putStr     = TIO.putStr                #-}
{-# COMPILE GHC putStrLn   = TIO.putStrLn              #-}
