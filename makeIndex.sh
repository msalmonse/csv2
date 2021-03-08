#!/bin/bash

#  makeIndex.sh
#  csv2svg
#
#  Created by Michael Salmon on 2021-03-05.
#  

exec > svg/index.html

# Headers
cat <<EOD
<html>
<head>
    <title>SVG test results</title>
    <style>
        img { border: ridge }
    </style>
</head>
<body>
<table>
EOD

for f in svg/*.svg
do
    cat <<EOD
<tr>
<th>$(cat "$f.txt")</th>
<td><img src="$(basename "$f")" /></td>
</tr>
EOD
done

# Footers
cat <<EOD
</table>
</body>
</head>
EOD
