#!/bin/bash

command="${@:-echo lol where is code}"

rm -f comment input output actualoutput

read testsep
read iosep

while read line ; do
  case "$line" in
    $testsep*) break ;;
    *) printf -- "$line\n" ;;
  esac
done

while true ; do
  while read line ; do
    case "$line" in
      $iosep*) break ;;
      *) printf -- "$line\n" ;;
    esac
  done >comment
  test -s comment || break
  while read line ; do
    case "$line" in
      $iosep*) break ;;
      *) printf -- "$line\n" ;;
    esac
  done >input
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
