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
    svg="$svgdir/$1-data+$2-json.svg"
    echo >&2 "Generating $svg"
    ./test/csv2svg "$csv" "$json" > "$svg" \
    && echo "$3" > "$svg.txt"
}

./test/csv2svg

sort $datadir/testlist.txt \
| while read csv json msg
do
    makeSVG "$csv" "$json" "$msg"
done
