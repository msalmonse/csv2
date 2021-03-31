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

rm -v "$dir/$name".{csv,json,opts,txt}
