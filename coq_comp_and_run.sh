#!/bin/bash
# important: we want to use the builtin time command of bash

# it is tricky to redirect the output of bash's time
# to a file
# {time <COMMAND> ;} 2> a.txt

if [ 1 -ne $# ]; then
  echo "Please provide the output file as a parameter" >&2
  exit 1
fi

echo "===========" >> "$1"

./clean.sh
{ time coqtop -l main.v -batch; } 2>> "$1"
./prepare_ocaml.sh main.ml
{ time ocamlc main.ml; } 2>> "$1"
{ time ./a.out ; } 1>> "$1" 2>> "$1"
./clean.sh
