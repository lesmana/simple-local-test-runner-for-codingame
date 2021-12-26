#!/bin/bash

# simple local test runner for codingame code
# Copyright Lesmana Zimmer lesmana@gmx.de
# Licensed under WTFPL version 2
# http://www.wtfpl.net/about/

if [ $# -eq 0 ]; then
  echo "need argument: command to run"
  echo "also need testdata piped or redirected to stdin"
  exit 1
fi

if [ -t 0 ]; then
  echo "need testdata piped or redirected on stdin"
  exit 1
fi

rm -f input expectedoutput actualoutput

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
  title=$(readto "$smallseparator")
  if [ -z "$title" ] ; then
    break
  else
    printf -- '%s\n' "$bigseparator"
    printf -- '%s\n' "$title"
  fi
  readto "$smallseparator" >input
  readto "$bigseparator" >expectedoutput
  printf -- '%s\n' "$smallseparator"
  "$@" <input | tee actualoutput
  printf -- '%s\n' "$smallseparator"
  if diff expectedoutput actualoutput ; then
    echo pass "$title"
    rm -f input expectedoutput actualoutput
  else
    printf -- '%s\n' "$smallseparator"
    echo fail "$title"
    exit 1
  fi
done

printf -- '%s\n' "$bigseparator"
echo all pass
