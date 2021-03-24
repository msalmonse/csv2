#!/bin/bash

#  makeIndex.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-05.
#  

exec > testout/index.html

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
EOD

for f in testout/*.svg
do
    test -s "$f" || continue
    cat <<EOD
<tr>
<th>$(cat "$f.txt")</th>
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
