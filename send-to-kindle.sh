#!/bin/bash

epub="$1"

calibre-smtp \
  --attachment "$epub" \
  --relay smtp.gmail.com \
  --port 587 \
  --username "txixco@gmail.com" \
  --password "wvpd dojk cent sdgs" \
  --encryption-method TLS \
  "txixco@gmail.com" "txixco-kindle@kindle.com" "Libro nuevo"

