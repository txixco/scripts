#! /usr/bin/bash

if [[ $# < 2 ]]; then
  echo "At least 2 parameters has to be passed"
  echo "  cutdata.sh NUM FILE_LIST"

  exit 1
fi

if ! [[ $1 =~ ^[0-9]+$ ]]; then
  echo "The first parameter must be the number of lines"

  exit 1
fi

lines=$1; shift

for file; do
  echo "Cortando el archivo '$file'"
  head -n $lines $file > tmp && mv tmp $file
done

