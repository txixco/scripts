#! /bin/bash

curl http://asdfast.beobit.net/api/\?length\=9\&startLorem\=true | jq .text | sed 's/"//g' | clip.exe
