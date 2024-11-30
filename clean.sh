#!/bin/sh

# for Coq
rm *.cm* 2>/dev/null
rm a.out 2>/dev/null
rm *.ml* 2>/dev/null

# for Agda
rm Main 2>/dev/null
rm -r _build/ 2>/dev/null
rm *.hs 2>/dev/null
rm *.hi 2>/dev/null
rm *.o 2>/dev/null

# for MAlonzo
rm MainGHC 2>/dev/null
rm -r MAlonzo 2>/dev/null
