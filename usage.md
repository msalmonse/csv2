### USAGE: `options [<options>] [<csv-name>] [<json-name>]`
```
ARGUMENTS:
  <csv-name>              CSV file name, "-" means use stdin
  <json-name>             JSON file name

OPTIONS:
  --bg <bg>               Background colour
  --bitmap <bitmap>       Convert a list of rows or columns to a bitmap
  --black                 Set default colour to black
  --colour <colour>       Default colour (default: black)
  --colours <colours>     Default list of plot colours, multiple entries until the next option
  --dashed <dashed>       Default plots to show as with dashed lines (default: 0)
  --dashes <dashes>       Default list of plot dash patterns, multiple entries until the next
                          option
  -d, --debug <debug>     Add debug info (default: 0)
  --distance <distance>   Minimum distance between data points (default: 10.0)
  --headers <headers>     Default header rows or columns (default: 0)
  --height <height>       Default svg height (default: 600)
  --index <index>         Default index row or column (default: 0)
  --include <include>     Default rows or columns to include (default: -1)
  --nameheader <nameheader>
                          Default plot name row or column (default: 1)
  --names <names>         Default list of plot names, multiple entries until the next option
  --nolegends             Don't include plot names, colours, dashes and shapes
  --opacity <opacity>     Default index row or column (default: 1.0)
  --rows                  Default to grouping data by rows
  --scattered <scattered> Default plots to show as scattered (default: 0)
  --shapes <shapes>       Default list of shapes, multiple entries until the next option
  --shapenames            Print a list of shape names
  --show <show>           Generate an SVG with just the named shape @ 6X strokewidth
  --showpoints <showpoints>
                          Default data plots with points (default: 0)
  --size <size>           Default font size (default: 10.0)
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
  -h, --help              Show help information.

```
