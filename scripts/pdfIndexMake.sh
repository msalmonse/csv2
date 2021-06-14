#!/bin/bash

#  makeIndex.sh
#  csv2
#
#  Created by Michael Salmon on 2021-03-05.
#

index=${1:-generated/pdfindex.html}
indexdir=$(dirname "$index")
exec > ${index}

# Headers
cat <<EOD
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>PDF test results</title>
    <style>
        img { border: black solid thin }
        object { margin: 0 }
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

cat <<EOD
<tr><th colspan="2" class="infoHeader">Generated Test PDF's</th></tr>
EOD

for f in "$indexdir"/*.pdftag
do
    test -s "$f" || continue
    txtf=${f/%.pdftag/.txt}
    test -s "$txtf" || continue
    base=$(basename "$f" .canvastag)
    cat <<EOD
<tr>
<th>
<a href="../data/$base.csv">$base.csv</a><br/>
<a href="../data/$base.json">$base.json</a><br/>
$(cat "$txtf")<br/>$(date -r "$f" '+%F %T %Z')
</th>
<td>
$(cat "$f")
</td>
</tr>
EOD
done

# Footers
cat <<EOD
<tr><th colspan="2" class="infoHeader">
<a href="jsindex.html">JS Index</a>
<a href="pngindex.html">PNG Index</a>
<a href="svgindex.html">SVG Index</a>
</th></tr>
</table>
</body>
</head>
EOD
