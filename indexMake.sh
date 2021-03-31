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
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>SVG test results</title>
    <style>
        img, svg { border: black solid thin }
	th { text-align: right }
    </style>
    <base target="_blank" />
</head>
<body>
<table>
<tr><th colspan="2" style="text-align: center">$(date '+%F %T %Z')</th></tr>
EOD
if [[ -s test.svg ]]
then
    cat <<EOD
<tr>
<th><a href="../test.svg">test.svg</a><br/>$(date -r test.svg '+%F %T %Z')</th>
<td>
$(tail -n +2 test.svg)
</td>
</tr>
EOD
fi

for f in "$indexdir"/*.svg
do
    test -s "$f" || continue
    txtf=${f/%.svg/.txt}
    test -s "$txtf" || continue
    cat <<EOD
<tr>
<th><a href="${f##*/}">${f##*/}</a><br/>$(cat "$txtf")<br/>$(date -r "$f" '+%F %T %Z')</th>
<td>
$(tail -n +2 "$f")
</td>
</tr>
EOD
done

cat <<EOD
<tr><th colspan="2" style="text-align: center">Examples</th></tr>
EOD

for f in examples/*.svg
do
    cat <<EOD
<tr>
<th>$(basename $f .svg)</th>
<td>
<img src="../$f" />
</td>
</tr>
EOD
done

cat <<EOD
<tr><th colspan="2" style="text-align: center">ICONS</th></tr>
EOD

for f in shapes/*.svg
do
    cat <<EOD
<tr>
<th>$(basename $f .svg)</th>
<td>
<img src="../$f" />
</td>
</tr>
EOD
done

# Footers
cat <<EOD
</table>
</body>
</head>
EOD
