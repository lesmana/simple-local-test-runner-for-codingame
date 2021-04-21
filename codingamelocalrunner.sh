#!/bin/bash

command="${@:-echo lol where is code}"

rm -f comment input output actualoutput

read testsep
read iosep

header() {
  line="$1"
  case "$line" in
    $testsep*) return 1 ;;
    *) printf -- "$line\n" ;;
  esac
}

while read line ; do
  header "$line" || break
done

comment() {
  line="$1"
  case "$line" in
    $iosep*) return 1 ;;
    *) printf -- "$line\n" >>comment ;;
  esac
}

input() {
  line="$1"
  case "$line" in
    $iosep*) return 1 ;;
    *) printf -- "$line\n" >>input ;;
  esac
}

while true ; do
  while read line ; do
    comment "$line" || break
  done
  test -s comment || break
  while read line ; do
    input "$line" || break
  done
  while read line ; do
    case "$line" in
      $testsep*) break ;;
      *) printf -- "$line\n" ;;
    esac
  done >output
  printf -- "$testsep\n"
  cat comment
  printf -- "$iosep\n"
  $command <input | tee actualoutput
  printf -- "$iosep\n"
  diff output actualoutput
  if [ $? -eq 0 ] ; then
    echo pass
    rm -f comment input output actualoutput
  else
    printf -- "$iosep\n"
    echo fail
    exit 1
  fi
done

printf -- "$testsep\n"
echo all pass
