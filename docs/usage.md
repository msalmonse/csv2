## csv2
```
Generate a Canvas, PDF, PNG or SVG using data from a CSV file and
settings from a JSON file.

csv2 <canvas|pdf|png|svg> [options] [csv file [json file [output file]]]
```

```
Arguments:
  <csv file>       CSV data file name or - for stdin
  <json file>      JSON settings file name
  <output file>    Output file name,
                   or stdout if omitted for canvas and svg
```

```
Common options:
  -bared <bitmap¹>
                   Plots to show as bars
  -baroffset <offset>
                   Bar offset (-1 to calculate)
  -barwidth        Bar width (-1 to calculate)
  -bezier <n>      Bézier curve smoothing, 0 means none
   environment variable: CVS2_BEZIER
  -bg <colour>     Background colour
   environment variable: CSV2_BACKGROUND_COLOUR
  -black           Set undefined colours to black
  -bold            Set font-weight to bold
  -bounds          Check options for bounds, nobounds to not check
   environment variable: CVS2_BOUNDS
  -chart <type>    The type of chart:
                   horizontal - index values horizontal and plot
                   values vertical,
                   pie - a grid of pie chart plots or,
                   vertical - a list of values, like a bar chart
                   only vertical.
                   A unique prefix is sufficient.
  -colours <colour>...
                   Colours to use for plots
   aka: colors
  -comment         Add csv2 comment to plot, nocomment to not add
  -dashed <bitmap¹>
                   Plots with dashed lines
  -dashes <n,n...>...
                   List of plot dash patterns to use
  -debug <bitmap¹>
                   Add debug info
  -distance <n>    Minimum distance between data points
  -draft [text]    Mark the chart as a draft,
                   the optional argument sets the text
  -fg <colour>     Foreground colour for non-text items
   environment variable: CSV2_FOREGROUND_COLOUR
  -filled <bitmap¹>
                   Plots to show filled
  -font <font name>
                   Font family
   environment variable: CVS2_FONT_FAMILY
  -headers <n>     Header rows or columns
  -height <n>      Chart height
   environment variable: CSV2_HEIGHT
  -include <bitmap¹>
                   Plots to include, default all
  -index <n>       Index row or column
  -italic          Use an italic font
  -legends         Show plot names, colours, dashes and shapes,
                   nolegends to not
  -logo <url>      Image URL for top right corner
   environment variable: CSV2_LOGO_URL
  -logx            Set abcissa to log
  -logy            Set ordinate to log
  -nameheader <n>
                   Plot name row or column
  -names <name>...
                   List of plot names
  -opacity         Opacity for plots
  -pointed <bitmap¹>
                   Data plots with points
   aka: datapoints, showpoints
  -random <n [n [n]]>
                   Generate a random SVG with:
                   #plots [max value [min value]]
  -reserve <n [n [n [n]]]>
                   Reserved space on the left [top [right [bottom]]]
  -rows            Group data by rows
  -scattered <bitmap¹>
                   Plots to show as scatter plots
  -semi            Use semicolons to separate columns
  -shapes <shape>...
                   List of shapes to use
  -size <n>        Base font size
   environment variable: CSV2_BASE_FONT_SIZE
  -smooth <n>      EMA smoothing, 0 means none
  -sortx           Sort points by the x values before plotting
  -stacked <bitmap¹>
                   Plots stacked
  -stroke <n>      Stroke width
   environment variable: CSV2_STROKE_WIDTH
  -subheader <n>   Sub-title row or column source
  -subtitle <text>
                   Sub-title
  -textcolour <colour>
                   Foreground text colour
   aka: textcolor
   environment variable: CSV2_TEXT_COLOUR
  -title <text>    Chart title
  -tsv             Use tabs to seperate columns
  -verbose         Add extra information
  -width <n>       Chart width
   environment variable: CSV2_WIDTH
  -xmax <n>        Abscissa maximum
  -xmin <n>        Abscissa minimum
  -xtags <n>       Row or column with abscissa tags
  -xtick <n>       Distance between abcissa ticks
  -ymax <n>        Ordinate maximum
  -ymin <n>        Ordinate minimum
  -ytick <n>       Distance between ordinate ticks
```

```
Canvas specific options:
  -canvas <name>   Canvas name
```

```
SVG specific options:
  -css <file>      Include file for css styling
  -cssid <id>      CSS id for <SVG> tag
  -hover           Add CSS code to emphasize hovered plots, nohover
                   to not add
   environment variable: CVS2_HOVER
  -svg <file>      Include file for svg elements
```

```
Help specific options:
  -indent <n>      Indent for option usage
  -left <n>        Left margin for help text
  -right <n>       Right margin for text
  -usage <n>       Left margin for option usage
```

```
  ¹ <bitmap> means a list of plot numbers like '1 2 3 4'
  corresponding to the rows or columns. Negative numbers form the
  upper bound on a range, i.e. '1 -4' is the same as '1 2 3 4'. The
  first number is initially 1 so in fact '-4' suffices.
  The word 'all' means all i.e. '1 -64', only on the command line
  though.
  The list must be terminated by a '--', either as a long argument
  or a literal '--'.

```
