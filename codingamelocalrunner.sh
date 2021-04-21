#!/bin/bash

state=header

command="${@:-echo lol where is code}"

rm -f comment input output actualoutput

read testsep
read iosep

header() {
  line="$1"
  case "$line" in
    $testsep*) state=comment ;;
    *) printf -- "$line\n" ;;
  esac
}

comment() {
  line="$1"
  case "$line" in
    $iosep*) state=input ;;
    *) printf -- "$line\n" >>comment ;;
  esac
}

input() {
  line="$1"
  case "$line" in
    $iosep*) state=output ;;
    *) printf -- "$line\n" >>input ;;
  esac
}

output() {
  line="$1"
  case "$line" in
    $testsep*) state=comment ; run ;;
    *) printf -- "$line\n" >>output ;;
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

while read line ; do
  $state "$line" || exit 1
done

printf -- "$testsep\n"
echo all pass
