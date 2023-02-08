#!/usr/bin/bash

find . -name '$1*' -not -name '*.hs'
find . -name '$1*' -not -name '*.hs' -delete

