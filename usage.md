### csv2
```
OVERVIEW: Generate a Canvas or SVG using data from a CSV file and settings from a JSON file.

USAGE: csv2 <subcommand> [<options>] [<csv-name>] [<json-name>] [<out-name>]

SUBCOMMANDS:
    canvas                  Plot data on an HTML Canvas using JavaScript
    png                     Plot data on a PNG image
    svg (default)           Plot data in an SVG

ARGUMENTS:
    <csv-name>              CSV file name, "-" means use stdin
    <json-name>             JSON file name
    <out-name>              Output file name, default is to print to terminal
```
```
JS OPTIONS:
    --canvas <canvas>       Canvas name (default: csvplot)
    --canvastag             Print the canvas tag for inclusion in an HTML file
```
```
SVG OPTIONS:
    --css <css>             Default include file for css styling
    --cssid <cssid>         Default id for SVG
    --svg <svg>             Default include file for svg elements
```
```
COMMON OPTIONS:
    --bg <bg>               Background colour
    --bitmap <bitmap>       Convert a list of rows or columns to a bitmap
    --bezier <bezier>       Bézier curve smoothing, 0 means none (default: 0.0)
    --black                 Set undefined colours to black
    --bold                  Set font-weight to bold
    --colourslist           Generate an SVG with all the colours on it
    --colours <colours>     List of plot colours to use, multiple entries until the next option
    --dashed <dashed>       Plots to show as with dashed lines (default: 0)
    --dashes <dashes>       List of plot dash patterns to use, multiple entries until the next
                            option
    --dasheslist            Generate an SVG with all the dashes on it
    -d, --debug <debug>     Add debug info (default: 0)
    --distance <distance>   Minimum distance between data points (default: 10.0)
    --font <font>           Font family (default: serif)
    --headers <headers>     Header rows or columns (default: 0)
    --height <height>       SVG/Canvas height (default: 600)
    --index <index>         Index row or column (default: 0)
    --italic                Use an italic font
    --include <include>     Rows or columns to include (default: -1)
    --logo <logo>           Image URL for top right corner
    --logx                  Set abcissa to log
    --logy                  Set ordinate to log
    --nameheader <nameheader>
                            Plot name row or column (default: 1)
    --names <names>         List of plot names, multiple entries until the next option
    --nobounds              Don't check options for bounds
    --nocomment             Don't add csv2 comment to plot
    --nohover               Don't add CSS code to emphasize hovered plots
    --nolegends             Don't include plot names, colours, dashes and shapes
    --opacity <opacity>     Opacity for plots (default: 1.0)
    --random <random>       Generate a random SVG with: #plots [max value [min value [-ve
                            offset]]]
    --reserve <reserve>     Reserved pixels on the left [top [right [bottom]]] (default: 0.0,
                            0.0, 0.0, 0.0)
    --rows                  Group data by rows
    --scattered <scattered> Plots to show as scattered (default: 0)
    -s, --semi              Use semicolons to seperate columns
    --shapes <shapes>       List of shapes to use, multiple entries until the next option
    --shapenames            Print a list of shape names
    --show <show>           Generate a plot with just the named shape @ 6X strokewidth
    --showpoints <showpoints>
                            Data plots with points (default: 0)
    --size <size>           Base font size (default: 10.0)
    --smooth <smooth>       EMA smoothing, 0 means none (default: 0.0)
    --sortx                 Sort points by the x values before plotting
    --stapled <stapled>     Plots to show as staple diagrams (default: 0)
    --stapleoffset <stapleoffset>
                            Staple offset (-1 to calculate) (default: -1.0)
    --staplewidth <staplewidth>
                            Staple width (-1 to calculate) (default: -1.0)
    --stroke <stroke>       Stroke width (default: 2.0)
    --subheader <subheader> Sub-title row or column source (default: 0)
    --subtitle <subtitle>   Sub-title
    --title <title>         Title
    -t, --tsv               Use tabs to seperate columns
    -v, --verbose           Add extra information
    -V, --version           Display version and exit
    --width <width>         SVG/Canvas width (default: 800)
    --xmax <xmax>           Default abscissa maximum (default: -inf)
    --xmin <xmin>           Default abscissa minimum (default: inf)
    --xtags <xtags>         Tag row or column (default: 0)
    --xtick <xtick>         Default x tick (default: 0.0)
    --ymax <ymax>           Default ordinate maximum (default: -inf)
    --ymin <ymin>           Default ordinate minimum (default: inf)
    --ytick <ytick>         Default y tick (default: 0.0)

    -h, --help              Show help information.
```
