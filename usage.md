### csv2svg
```
OVERVIEW: Generate an SVG using data from a CSV file and settings from a JSON file.

USAGE: csv2svg [<options>] [<csv-name>] [<json-name>]

ARGUMENTS:
  <csv-name>              CSV file name, "-" means use stdin
  <json-name>             JSON file name

OPTIONS:
  --bg <bg>               Background colour
  --bitmap <bitmap>       Convert a list of rows or columns to a bitmap
  --black                 Set default colour to black
  --bold                  Set default font-weight to bold
  --colourslist           Generate an SVG with all the colours on it
  --colours <colours>     Default list of plot colours, multiple entries until the next option
  --dashed <dashed>       Default plots to show as with dashed lines (default: 0)
  --dashes <dashes>       Default list of plot dash patterns, multiple entries until the next
                          option
  --dasheslist            Generate an SVG with all the dashes on it
  -d, --debug <debug>     Add debug info (default: 0)
  --distance <distance>   Minimum distance between data points (default: 10.0)
  --font <font>           Default font family
  --headers <headers>     Default header rows or columns (default: 0)
  --height <height>       Default svg height (default: 600)
  --index <index>         Default index row or column (default: 0)
  --italic                Set default colour to black
  --include <include>     Default rows or columns to include (default: -1)
  --logx                  Set default for abcissa to log
  --logy                  Set default for ordinate to log
  --nameheader <nameheader>
                          Default plot name row or column (default: 1)
  --names <names>         Default list of plot names, multiple entries until the next option
  --nolegends             Don't include plot names, colours, dashes and shapes
  --opacity <opacity>     Default index row or column (default: 1.0)
  --random <random>       Generate a random SVG with: #plots [max value [min value]]
  --rows                  Default to grouping data by rows
  --scattered <scattered> Default plots to show as scattered (default: 0)
  --shapes <shapes>       Default list of shapes, multiple entries until the next option
  --shapenames            Print a list of shape names
  --show <show>           Generate an SVG with just the named shape @ 6X strokewidth
  --showpoints <showpoints>
                          Default data plots with points (default: 0)
  --size <size>           Default font size (default: 10.0)
  --smooth <smooth>       Default smoothing, 0 means none (default: 0.0)
  --sortx                 Sort points by the x values before plotting
  --stroke <stroke>       Default stroke width (default: 2.0)
  --subheader <subheader> Default sub-title row or column (default: 0)
  --subtitle <subtitle>   Default sub-title
  --title <title>         Default title
  -t, --tsv               Use tabs to seperate columns
  -v, --verbose           Add extra information
  -V, --version           Display version and exit
  --width <width>         Default svg width (default: 800)
  --xmax <xmax>           Default abscissa maximum (default: -inf)
  --xmin <xmin>           Default abscissa minimum (default: inf)
  --xtick <xtick>         Default x tick (default: 0.0)
  --ymax <ymax>           Default ordinate maximum (default: -inf)
  --ymin <ymin>           Default ordinate minimum (default: inf)
  --ytick <ytick>         Default y tick (default: 0.0)
  --version               Show the version.
  -h, --help              Show help information.

```
