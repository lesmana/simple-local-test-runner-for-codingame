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
      *) printf -- "$line\n" ;;
    esac
  done
}

readtosep "$testsep"

while true ; do
  comment=$(readtosep "$iosep")
  if [ -z "$comment" ] ; then
    break
  else
    printf -- "$testsep\n"
    printf -- "$comment\n"
  fi
  readtosep "$iosep" >input
  readtosep "$testsep" >output
  printf -- "$iosep\n"
  $command <input | tee actualoutput
  printf -- "$iosep\n"
  diff output actualoutput
  if [ $? -eq 0 ] ; then
    echo pass
    rm -f input output actualoutput
  else
    printf -- "$iosep\n"
    echo fail
    exit 1
  fi
done

printf -- "$testsep\n"
echo all pass
