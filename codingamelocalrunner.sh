#!/bin/bash

state=header

if [ -x code.sh ] ; then
  command="./code.sh"
else
  command="echo lol where is code"
fi

header() {
  case "$1" in
    ====*) state=comment ;;
    *) printf -- "$1\n" ;;
  esac
}

comment() {
  case "$1" in
    ----*) state=input ;;
    *) printf -- "$1\n" >>comment ;;
  esac
}

input() {
  case "$1" in
    ----*) state=output ;;
    *) printf -- "$1\n" >>input ;;
  esac
}

output() {
  case "$1" in
    ====*) state=comment ; run ;;
    *) printf -- "$1\n" >>output ;;
  esac
}

run() {
  echo ========================================================
  if [ -e comment ] ; then
    cat comment
    echo -----------------------------------------------------
  fi
  $command <input | tee actualoutput
  echo ------------------------------------------------------
  diff output actualoutput
  if [ $? -eq 0 ] ; then
    echo pass
    rm -f comment input output actualoutput
    return 0
  else
    echo ------------------------------------------------------
    echo fail
    return 1
  fi
}

rm -f comment input output actualoutput

while read line ; do
  $state "$line" || exit 1
done

echo all pass
