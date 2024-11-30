#!/bin/sh
# This is to make the extracted OCaml file
# able to be compiled.

# removing the .mli file
rm "$1i" 2>/dev/null

if [ 1 -ne $# ]; then
  echo "Please provide the OCaml filename (*.ml) as a parameter" >&2
  exit 1
elif grep -q "let () = " "$1"; then
  echo "This has probably already been prepared" >&2
  exit 1
elif grep -q "boolToPrint" "$1"; then
  echo "\nlet () = print_endline (if boolToPrint then \"true\" else \"false\")\n" >> "$1"
elif grep -q "natToPrint" "$1"; then
  echo "\nlet () = print_int natToPrint\n; print_newline ()" >> "$1"
else
  echo "No \"boolToPrint\" or \"natToPrint\" definition found" >&2
  exit 1
fi

