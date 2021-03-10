#!/bin/bash

#  runTests.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-05.
#

datadir=testdata
svgdir=svg

makeSVG () {
    csv="$datadir/$1.csv"
    json="$datadir/$2.json"
    svg="$svgdir/$1-data+$3+$2-json.svg"
    echo >&2 "Generating $svg"
    ./test/csv2svg ${opts//,/ } "$csv" "$json" > "$svg" \
    && echo "$4" > "$svg.txt"
}

./test/csv2svg -V

sort $datadir/testlist.txt \
| while read csv json opts msg
do
    makeSVG "$csv" "$json" "$opts" "$msg"
done
