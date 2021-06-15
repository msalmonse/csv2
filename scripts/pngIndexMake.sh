#!/bin/bash

#  makeIndex.sh
#  csv2
#
#  Created by Michael Salmon on 2021-03-05.
#  

index=${1:-generated/pngindex.html}
indexdir=$(dirname "$index")
exec > ${index}

# Headers
cat <<EOD
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>PNG test results</title>
    <style>
        img, png { border: black solid thin }
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
if [[ -s out.png ]]
then
    cat <<EOD
<tr><th colspan="2" class="infoHeader">out.png</th></tr>
<tr>
<th><a href="../out.png">out.png</a><br/>$(date -r out.png '+%F %T %Z')</th>
<td>
<img src="../out.png" />
</td>
</tr>
EOD
fi

cat <<EOD
<tr><th colspan="2" class="infoHeader">Generated Test PNG's</th></tr>
EOD

for f in "$indexdir"/*.png
do
    test -s "$f" || continue
    txtf=${f/%.png/.txt}
    test -s "$txtf" || continue
    base=$(basename "$f" .png)
    cat <<EOD
<tr>
<th>
<a href="${f##*/}">${f##*/}</a><br/>
<a href="../data/$base.csv">$base.csv</a><br/>
<a href="../data/$base.json">$base.json</a><br/>
$(cat "$txtf")<br/>$(date -r "$f" '+%F %T %Z')
</th>
<td>
<img src="$base.png" />
</td>
</tr>
EOD
done

# Footers
cat <<EOD
<tr><th colspan="2" class="infoHeader">
<a href="jsindex.html">JS Index</a>
<a href="pdfindex.html">PDF Index</a>
<a href="svgindex.html">SVG Index</a>
</th></tr>
</table>
</body>
</head>
EOD
