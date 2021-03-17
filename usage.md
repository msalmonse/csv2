### USAGE: `options [<options>] [<csv-name>] [<json-name>]`
```
ARGUMENTS:
  <csv-name>              CSV file name, "-" means use stdin
  <json-name>             JSON file name

OPTIONS:
  --bg <bg>               Background colour
  --black                 Set default colour to black
  --colour <colour>       Default colour (default: black)
  --dashed <dashed>       Default plots to show as with dashed lines (default: 0)
  -d, --debug <debug>     Add debug info (default: 0)
  --distance <distance>   Minimum distance between data points (default: 10.0)
  --headers <headers>     Default header rows or columns (default: 0)
  --height <height>       Default svg height (default: 600)
  --index <index>         Default index row or column (default: 0)
  --opacity <opacity>     Default index row or column (default: 1.0)
  --rows                  Default to grouping data by rows
  --scattered <scattered> Default plots to show as scattered (default: 0)
  --shapes                Print a list of shape names
  --show <show>           Generate an SVG with just the named shape @ 6X strokewidth
  --showpoints <showpoints>
                          Default data plots with points (default: 0)
  --size <size>           Default font size (default: 10.0)
  --sortx                 Sort points by the x values before plotting
  --stroke <stroke>       Default stroke width (default: 2.0)
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
  -h, --help              Show help information.

```
