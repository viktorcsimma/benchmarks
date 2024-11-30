#!/bin/bash
# important: we want to use the builtin time command of bash

# it is tricky to redirect the output of bash's time
# to a file
# { time <COMMAND> ; } 2> a.txt

if [ 1 -ne $# ]; then
  echo "Please provide the output file as a parameter" >&2
  exit 1
fi

./clean.sh

echo "===========" >> "$1"
{ time agda --ghc --ghc-dont-call-ghc MainGHC.agda -vprofile:7 +RTS -M10G > /dev/null; } 2>> "$1"

# check out how it goes with optimisation
for level in `seq 0 2`; do
  echo "Ran with option -O$level" >> "$1"
  { time ghc -O$level -o MainGHC -main-is MAlonzo.Code.MainGHC MAlonzo/Code/MainGHC.hs >/dev/null; } 2>> "$1"
  { time ./MainGHC; } 1>> "$1" 2>> "$1"
  rm MainGHC
  find MAlonzo/ -name "*.hi" -type f -delete
  find MAlonzo/ -name "*.o" -type f -delete
done

./clean.sh
