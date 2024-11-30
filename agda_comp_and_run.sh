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
{ time agda2hs Main.agda -vprofile:7 +RTS -M10G; } 2>> "$1"

# check out how it goes with optimisation
for level in `seq 0 2`; do
  echo "Ran with option -O$level" >> "$1"
  { time ghc -O$level Main.hs; } 2>> "$1"
  
  { time ./Main; } 1>> "$1" 2>> "$1"
  rm Main Main.o Main.hi
done

./clean.sh
