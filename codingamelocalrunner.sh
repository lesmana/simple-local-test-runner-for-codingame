#!/bin/bash

state=header

command="$@"
command="${command:-echo lol where is code}"

header() {
  case "$1" in
    $testsep*) state=comment ;;
    *) printf -- "$1\n" ;;
  esac
}

comment() {
  case "$1" in
    $iosep*) state=input ;;
    *) printf -- "$1\n" >>comment ;;
  esac
}

input() {
  case "$1" in
    $iosep*) state=output ;;
    *) printf -- "$1\n" >>input ;;
  esac
}

output() {
  case "$1" in
    $testsep*) state=comment ; run ;;
    *) printf -- "$1\n" >>output ;;
  esac
}

run() {
  printf -- "$testsep\n"
  if [ -e comment ] ; then
    cat comment
    printf -- "$iosep\n"
  fi
  $command <input | tee actualoutput
  printf -- "$iosep\n"
  diff output actualoutput
  if [ $? -eq 0 ] ; then
    echo pass
    rm -f comment input output actualoutput
    return 0
  else
    printf -- "$iosep\n"
    echo fail
    return 1
  fi
}

rm -f comment input output actualoutput

read testsep
read iosep

while read line ; do
  $state "$line" || exit 1
done

printf -- "$testsep\n"
echo all pass
