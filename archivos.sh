#!/bin/bash

directory="."
label="Archivos"

while getopts ":d:l:" opt; do
  case $opt in
    d) directory="$OPTARG"
    ;;
    l) label="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

echo "$label:"
for file in $directory/*
do
	echo "  - ${file##*/}"
done
