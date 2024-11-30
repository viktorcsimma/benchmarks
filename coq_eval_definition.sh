#!/bin/sh

if [ 0 -eq $# ]; then
  echo "Please add at least one definition to uncomment" >&2
  exit 1
fi

sh clean.sh

for arg in "$@"; do
  if ! grep -q "^(\* Definition ${arg} .* \*)$" main.v; then
    echo "Warning: definition \"${arg}\" not found, or already uncommented" >&2
  else
    sed 's/^(\* Definition ${arg} \(.*\) \*)$/Definition ${arg} \1/g' main.v > maintemp.v
  fi
done

time coqtop -l maintemp.v -batch -type-in-type -time

rm maintemp.v
