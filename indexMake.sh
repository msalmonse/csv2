#!/bin/bash

#  makeIndex.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-05.
#  

index=${1:-testout/index.html}
indexdir=$(dirname "$index")
exec > ${index}

# Headers
cat <<EOD
<html>
<head>
    <title>SVG test results</title>
    <style>
        img { border: black solid thin }
	th { text-align: right }
    </style>
</head>
<body>
<table>
<tr><th colspan="2" style="text-align: center">$(date '+%F %T %Z')</th></tr>
EOD
if [[ -s test.svg ]]
then
    cat <<EOD
<tr>
<th>test.svg<br/>$(date -r test.svg '+%F %T %Z')</th>
<td><img src="../test.svg" /></td>
</tr>
EOD
fi

for f in "$indexdir"/*.svg
do
    test -s "$f" || continue
    txtf=${f/%.svg/.txt}
    cat <<EOD
<tr>
<th>$(cat "$txtf")<br/>$(date -r "$f" '+%F %T %Z')</th>
<td><img src="$(basename "$f")" /></td>
</tr>
EOD
done

for f in shapes/*.svg
do
    cat <<EOD
<tr>
<th>$(basename $f .svg)</th>
<td><img src="../$f" /></td>
</tr>
EOD
done

# Footers
cat <<EOD
</table>
</body>
</head>
EOD
