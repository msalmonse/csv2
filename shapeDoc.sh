#!/bin/bash

#  shapeDoc.sh
#  csv2
#
#  Created by Michael Salmon on 2021-03-12.
#  

for shape in $(./test/csv2 --shapenames)
do
    ./test/csv2 --nocomment --show $shape "$@" > shapes/$shape.svg
done
