#!/bin/bash

if [[ $# = 0 ]]
then
	cat >&2 <<EOD
$0 <csv name> <json name> <count>
EOD
	exit 0
fi

dir=data
name="$1+$2-$3"

if [[ -e "$dir/$name.csv" ]]
then
	echo >&2 $name exists
	exit 1
fi

ln -s "$1.csv" "$dir/$name.csv"
ln -s "$2.json" "$dir/$name.json"
vi "$dir/$name.opts" "$dir/$name.txt"
