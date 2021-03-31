#!/bin/bash

#  makeExamples.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-21.
#  

makeit () {
    svg=examples/"$1".svg; shift
    test/csv2svg "$@" examples/trig.{csv,json} $svg
}

makeit trig
makeit trig-80-120 --xmin=80 --xmax=120
makeit trig-2plots --include=40
makeit trig-points --showpoints=8 --scattered=16
