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
        img { border: outset }
    </style>
</head>
<body>
EOD

for f in svg/*.svg
do
    cat <<EOD
<h3>$(cat "$f.txt")</h3>
<img src="$(basename "$f")" />
EOD
done

# Footers
cat <<EOD
</body>
</head>
EOD
