#!/bin/bash

#  makeIndex.sh
#  csv2
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
	th.infoHeader {
	    text-align: center; font-size: bigger; color: blue; background: #c0ffee
	}
    </style>
    <base target="_blank" />
</head>
<body>
<table>
<tr><th colspan="2" class="infoHeader">$(date '+%F %T %Z')</th></tr>
EOD
if [[ -s test.svg ]]
then
    cat <<EOD
<tr><th colspan="2" class="infoHeader">test.svg</th></tr>
<tr>
<th><a href="../test.svg">test.svg</a><br/>$(date -r test.svg '+%F %T %Z')</th>
<td>
$(tail -n +2 test.svg)
</td>
</tr>
EOD
fi

cat <<EOD
<tr><th colspan="2" class="infoHeader">Generated Test SVG's</th></tr>
EOD

for f in "$indexdir"/*.svg
do
    test -s "$f" || continue
    txtf=${f/%.svg/.txt}
    test -s "$txtf" || continue
    base=$(basename "$f" .svg)
    cat <<EOD
<tr>
<th>
<a href="${f##*/}">${f##*/}</a><br/>
<a href="../data/$base.csv">$base.csv</a><br/>
<a href="../data/$base.json">$base.json</a><br/>
$(cat "$txtf")<br/>$(date -r "$f" '+%F %T %Z')
</th>
<td>
$(tail -n +2 "$f")
</td>
</tr>
EOD
done

cat <<EOD
<tr><th colspan="2" class="infoHeader">Examples</th></tr>
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
<tr><th colspan="2" class="infoHeader">ICONS</th></tr>
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
