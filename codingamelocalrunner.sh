#!/bin/bash

if [ $# -eq 0 ]; then
  echo "need argument: command to run"
  echo "also need testdata piped or redirected to stdin"
  exit 1
fi

rm -f input output actualoutput

read -r bigseparator
read -r smallseparator

function readto() {
  sep="$1"
  while IFS= read -r ; do
    case "$REPLY" in
      $sep*) break ;;
      *) printf -- '%s\n' "$REPLY" ;;
    esac
  done
}

readto "$bigseparator"

while true ; do
  comment=$(readto "$smallseparator")
  if [ -z "$comment" ] ; then
    break
  else
    printf -- '%s\n' "$bigseparator"
    printf -- '%s\n' "$comment"
  fi
  readto "$smallseparator" >input
  readto "$bigseparator" >output
  printf -- '%s\n' "$smallseparator"
  "$@" <input | tee actualoutput
  printf -- '%s\n' "$smallseparator"
  if diff output actualoutput ; then
    echo pass
    rm -f input output actualoutput
  else
    printf -- '%s\n' "$smallseparator"
    echo fail
    exit 1
  fi
done

printf -- '%s\n' "$bigseparator"
echo all pass
