#!/bin/bash

#  shapeDoc.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-12.
#  

for shape in $(./test/csv2svg --shapenames)
do
    ./test/csv2svg --show $shape "$*" > shapes/$shape.svg
done
