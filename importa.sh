#!/bin/bash

nombre=`date +%Y%m%d%H%M%S`

import ~/.screenshots/$nombre.jpg
eog ~/.screenshots/$nombre.jpg
rm ~/.screenshots/$nombre.jpg
