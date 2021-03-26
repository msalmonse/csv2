#!/bin/bash

if [[ $# = 0 ]]
then
	cat >&2 <<EOD
$0 <csv name> <json name> <count>
EOD
	exit 0
fi

dir=testdata
name="$1+$2-$3"

vi "$dir/$name.opts" "$dir/$name.txt"
