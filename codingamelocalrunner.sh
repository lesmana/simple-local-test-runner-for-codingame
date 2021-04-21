#!/bin/bash

command="${@:-echo lol where is code}"

rm -f input output actualoutput

read testsep
read iosep

function readtosep() {
  sep="$1"
  while read line ; do
    case "$line" in
      $sep*) break ;;
      *) printf -- '%s\n' "$line" ;;
    esac
  done
}

readtosep "$testsep"

while true ; do
  comment=$(readtosep "$iosep")
  if [ -z "$comment" ] ; then
    break
  else
    printf -- '%s\n' "$testsep"
    printf -- '%s\n' "$comment"
  fi
  readtosep "$iosep" >input
  readtosep "$testsep" >output
  printf -- '%s\n' "$iosep"
  $command <input | tee actualoutput
  printf -- '%s\n' "$iosep"
  diff output actualoutput
  if [ $? -eq 0 ] ; then
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
