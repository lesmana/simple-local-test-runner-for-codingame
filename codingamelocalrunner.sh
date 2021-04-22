#!/bin/bash

if [ $# -eq 0 ]; then
  echo "need argument: command to run"
  echo "also need testdata piped or redirected to stdin"
  exit 1
fi

rm -f input output actualoutput

read -r testsep
read -r iosep

function readto() {
  sep="$1"
  while IFS= read -r ; do
    case "$REPLY" in
      $sep*) break ;;
      *) printf -- '%s\n' "$REPLY" ;;
    esac
  done
}

readto "$testsep"

while true ; do
  comment=$(readto "$iosep")
  if [ -z "$comment" ] ; then
    break
  else
    printf -- '%s\n' "$testsep"
    printf -- '%s\n' "$comment"
  fi
  readto "$iosep" >input
  readto "$testsep" >output
  printf -- '%s\n' "$iosep"
  "$@" <input | tee actualoutput
  printf -- '%s\n' "$iosep"
  if diff output actualoutput ; then
    echo pass
    rm -f input output actualoutput
  else
    printf -- '%s\n' "$iosep"
    echo fail
    exit 1
  fi
done

printf -- '%s\n' "$testsep"
echo all pass
