#!/bin/bash
# Tests how fast Agda evaluates an expression live.
# Serves as a cognate for Eval commands in Coq.
# We pass something like "cBoolToBool (forceTree (t23 {CBool Bool}))".

if [ 1 -ne $# ]; then
  echo "Please provide the expression you would like to evaluate" >&2
  exit 1
fi

echo "$1" | { time agda --interactive Main.agda; } >/dev/null

