{-# OPTIONS --erasure #-}

open import Agda.Builtin.Nat
open import Haskell.Prim.Show
open import Haskell.Prim.String
open import Haskell.Prim using (the)
open import Agda.Builtin.Bool
open import Haskell.Prim.Bool
open import Haskell.Prim.IO
open import Agda.Builtin.Unit

@0 EqProp : {a : Set} → a → a → Set₁
EqProp {a} x y = (P : a → Set) → P x → P y

@0 refl : {a : Set}{x : a} → EqProp {a} x x; refl
 = λ P px → px

--------------------------------------------------------------------------------
-- Naturals
--------------------------------------------------------------------------------


CNat : Set → Set
CNat a = (a → a) → a → a
{-# COMPILE AGDA2HS CNat #-}

cNatToNat : CNat Nat -> Nat
cNatToNat n = n (1 +_) 0      -- this is what agda2hs supports
{-# COMPILE AGDA2HS cNatToNat #-}

showCNat : CNat Nat → String
showCNat n = show (cNatToNat n)
{-# COMPILE AGDA2HS showCNat #-}

add : {a : Set} → CNat a → CNat a → CNat a
add n m s z = n s (m s z)
{-# COMPILE AGDA2HS add #-}

mul : {a : Set} → CNat a → CNat a → CNat a
mul n m s = n (m s)
{-# COMPILE AGDA2HS mul #-}

cSuc : {a : Set} → CNat a → CNat a
cSuc n s z = s (n s z)
{-# COMPILE AGDA2HS cSuc #-}

n2  : {a : Set} → CNat a; n2 = λ s z → s (s z)
n3  : {a : Set} → CNat a; n3 = λ s z → s (s (s z))
n4  : {a : Set} → CNat a; n4 = λ s z → s (s (s (s z)))
n5  : {a : Set} → CNat a; n5 = λ s z → s (s (s (s (s z))))
{-# COMPILE AGDA2HS n2 #-}
{-# COMPILE AGDA2HS n3 #-}
{-# COMPILE AGDA2HS n4 #-}
{-# COMPILE AGDA2HS n5 #-}

n10 n10b n15 n15b n18 n18b n19 n19b n20
  n20b n21 n21b n22 n22b n23 n23b n100
  n100b n10k n10kb n100k n100kb
  n1M n1Mb n5M n5Mb n10M n10Mb
  n100M n500M n1G : {a : Set} → CNat a
n10    = mul n2 n5
n10b   = mul n5 n2
n15    = add n10  n5
n15b   = add n10b n5
n18    = add n15  n3
n18b   = add n15b n3
n19    = add n15  n4
n19b   = add n15b n4
n20    = mul n2 n10
n20b   = mul n2 n10b
n21    = cSuc n20
n21b   = cSuc n20b
n22    = cSuc n21
n22b   = cSuc n21b
n23    = cSuc n22
n23b   = cSuc n22b
n100   = mul n10   n10
n100b  = mul n10b  n10b
n10k   = mul n100  n100
n10kb  = mul n100b n100b
n100k  = mul n10k  n10
n100kb = mul n10kb n10b
n1M    = mul n10k  n100
n1Mb   = mul n10kb n100b
n5M    = mul n1M   n5
n5Mb   = mul n1Mb  n5
n10M   = mul n5M   n2
n10Mb  = mul n5Mb  n2
-- I add these myself for runtime tests
n100M  = mul n10M n10
n500M  = mul n5M n100
n1G    = mul n10M n100
{-# COMPILE AGDA2HS n10 #-}
{-# COMPILE AGDA2HS n10b #-}
{-# COMPILE AGDA2HS n15 #-}
{-# COMPILE AGDA2HS n15b #-}
{-# COMPILE AGDA2HS n18 #-}
{-# COMPILE AGDA2HS n18b #-}
{-# COMPILE AGDA2HS n19 #-}
{-# COMPILE AGDA2HS n19b #-}
{-# COMPILE AGDA2HS n20 #-}
{-# COMPILE AGDA2HS n20b #-}
{-# COMPILE AGDA2HS n21 #-}
{-# COMPILE AGDA2HS n21b #-}
{-# COMPILE AGDA2HS n22 #-}
{-# COMPILE AGDA2HS n22b #-}
{-# COMPILE AGDA2HS n23 #-}
{-# COMPILE AGDA2HS n23b #-}
{-# COMPILE AGDA2HS n100 #-}
{-# COMPILE AGDA2HS n100b #-}
{-# COMPILE AGDA2HS n10k #-}
{-# COMPILE AGDA2HS n10kb #-}
{-# COMPILE AGDA2HS n100k #-}
{-# COMPILE AGDA2HS n100kb #-}
{-# COMPILE AGDA2HS n1M #-}
{-# COMPILE AGDA2HS n1Mb #-}
{-# COMPILE AGDA2HS n5M #-}
{-# COMPILE AGDA2HS n5Mb #-}
{-# COMPILE AGDA2HS n10M #-}
{-# COMPILE AGDA2HS n10Mb #-}
{-# COMPILE AGDA2HS n100M #-}
{-# COMPILE AGDA2HS n500M #-}
{-# COMPILE AGDA2HS n1G #-}

--------------------------------------------------------------------------------
-- Trees
--------------------------------------------------------------------------------

CBool : Set → Set
CBool a = a → a → a
{-# COMPILE AGDA2HS CBool #-}

cBoolToBool : CBool Bool → Bool
cBoolToBool b = b true false
{-# COMPILE AGDA2HS cBoolToBool #-}

showCBool : CBool Bool → String
showCBool b = show (cBoolToBool b)
{-# COMPILE AGDA2HS showCBool #-}

cTrue : {a : Set} → CBool a
cTrue = λ t _ →  t
{-# COMPILE AGDA2HS cTrue #-}

cAnd : {a : Set} → CBool a → CBool a → CBool a
cAnd a b t f = a (b t f) f
{-# COMPILE AGDA2HS cAnd #-}

Tree : Set → Set
Tree a = (a → a → a) → a → a
{-# COMPILE AGDA2HS Tree #-}

leaf : {a : Set} → Tree a; leaf = λ n l → l
node : {a : Set} → Tree a → Tree a → Tree a; node = λ t1 t2 n l → n (t1 n l) (t2 n l)
{-# COMPILE AGDA2HS leaf #-}
{-# COMPILE AGDA2HS node #-}

fullTree : {a : Set} → CNat (Tree a) → Tree a
fullTree {a} n = n (λ t → node t t) (the (Tree a) leaf)
{-# COMPILE AGDA2HS fullTree #-}

fullTreeWithLeaf : {a : Set} → Tree a → CNat (Tree a) → Tree a
fullTreeWithLeaf bottom n = n (λ t → node t t) bottom
{-# COMPILE AGDA2HS fullTreeWithLeaf #-}

-- this forces the runtime to evaluate the entire tree
forceTree : {a : Set} → Tree (CBool a) → CBool a; forceTree
 = λ t → t cAnd cTrue
{-# COMPILE AGDA2HS forceTree #-}
-- By default, GHC will try to calculate this compile-time,
-- which is quite hard for it
-- (and also makes benchmark results quite inexplicable).
-- To avoid this:
{-# FOREIGN AGDA2HS {-# NOINLINE forceTree #-} #-}

t15 t15b t18 t18b t19 t19b t20 t20b
  t21 t21b t22 t22b t23 t23b : {a : Set} → Tree a
t15  = fullTree n15
t15b = fullTree n15b
t18  = fullTree n18
t18b = fullTree n18b
t19  = fullTree n19
t19b = fullTree n19b
t20  = fullTree n20
t20b = fullTree n20b
t21  = fullTree n21
t21b = fullTree n21b
t22  = fullTree n22
t22b = fullTree n22b
t23  = fullTree n23
t23b = fullTree n23b
{-# COMPILE AGDA2HS t15 #-}
{-# COMPILE AGDA2HS t15b #-}
{-# COMPILE AGDA2HS t18 #-}
{-# COMPILE AGDA2HS t18b #-}
{-# COMPILE AGDA2HS t19 #-}
{-# COMPILE AGDA2HS t19b #-}
{-# COMPILE AGDA2HS t20 #-}
{-# COMPILE AGDA2HS t20b #-}
{-# COMPILE AGDA2HS t21 #-}
{-# COMPILE AGDA2HS t21b #-}
{-# COMPILE AGDA2HS t22 #-}
{-# COMPILE AGDA2HS t22b #-}
{-# COMPILE AGDA2HS t23 #-}
{-# COMPILE AGDA2HS t23b #-}

--------------------------------------------------------------------------------
-- Nat conversion
--------------------------------------------------------------------------------

-- @0 convn1M : {a : Set} → EqProp (n1M {a}) n1Mb; convn1M = refl
-- @0 convn5M : {a : Set} → EqProp (n5M {a}) n5Mb; convn5M = refl
-- @0 convn10M : {a : Set} → EqProp (n10M {a}) n10Mb; convn10M = refl

--------------------------------------------------------------------------------
-- Full tree conversion
--------------------------------------------------------------------------------

-- @0 convt15  : {a : Set} → EqProp (t15 {a})  t15b; convt15  = refl -- 16 ms
-- @0 convt18  : {a : Set} → EqProp (t18 {a})  t18b; convt18  = refl -- 20 ms
-- @0 convt19  : {a : Set} → EqProp (t19 {a})  t19b; convt19  = refl -- 30 ms
-- @0 convt20  : {a : Set} → EqProp (t20 {a})  t20b; convt20  = refl -- 1.7 s
-- @0 convt21  : {a : Set} → EqProp (t21 {a})  t21b; convt21  = refl -- 3.4 s
-- @0 convt22  : {a : Set} → EqProp (t22 {a})  t22b; convt22  = refl -- 6.6 s
-- @0 convt23  : {a : Set} → EqProp (t23 {a})  t23b; convt23  = refl -- 13.1 s


-- TODO: what about the "Eval vm_compute" lines?

--------------------------------------------------------------------------------
-- Compiled Nat evaluation
--------------------------------------------------------------------------------

putCNat : CNat Nat → IO ⊤
putCNat n = putStrLn (showCNat n)
{-# COMPILE AGDA2HS putCNat #-}

main = putCNat n500M
{-# COMPILE AGDA2HS main #-}

--------------------------------------------------------------------------------
-- Compiled full tree evaluation
--------------------------------------------------------------------------------

{-
evalForceTree : Tree (CBool Bool) → IO ⊤
evalForceTree t = putStrLn (show (cBoolToBool (forceTree t)))
{-# COMPILE AGDA2HS evalForceTree #-}

main = evalForceTree t23
{-# COMPILE AGDA2HS main #-}
-}

