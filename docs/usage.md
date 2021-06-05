### csv2

```
Generate a Canvas, PDF, PNG or SVG using data from a CSV file
and settings from a JSON file.

csv2 <canvas|pdf|png|svg> [options] [csv file [json file [output file]]]
```
```
Arguments:
  <csv file>           CSV data file name or - for stdin
  <json file>          JSON settings file name
  <output file>        Output file name, use stdout if omitted
                       for canvas and svg
```
```
Common options:
  -bared <bitmap¹>     Plots to show as bars
  -baroffset <offset>
                       Bar offset (-1 to calculate)
  -barwidth            Bar width (-1 to calculate)
  -bezier <n>          Bézier curve smoothing, 0 means none
  -bg <colour>         Background colour
  -black               Set undefined colours to black
  -bold                Set font-weight to bold
  -bounds              Check options for bounds, nobounds to
                       not check
  -chart <type>        The type of chart, horizontal, pie or,
                       vertical
  -colours <colour>...
                       Colours to use for plots
   aka: colors
  -comment             Add csv2 comment to plot, nocomment to
                       not add
  -dashed <bitmap¹>    Plots with dashed lines
  -dashes <n,n...>...
                       List of plot dash patterns to use
  -debug <bitmap¹>     Add debug info
  -distance <n>        Minimum distance between data points
  -draft [text]        Mark the chart as a draft, argument sets
                       the text
  -fg <colour>         Foreground colour for non-text items
  -filled <bitmap¹>    Plots to show filled
  -font <font name>    Font family
  -headers <n>         Header rows or columns
  -height <n>          Chart height
  -include <bitmap¹>   Plots to include, default all
  -index <n>           Index row or column
  -italic              Use an italic font
  -legends             Show plot names, colours, dashes and
                       shapes, nolegends to not
  -logo <url>          Image URL for top right corner
  -logx                Set abcissa to log
  -logy                Set ordinate to log
  -nameheader <n>      Plot name row or column
  -names <name>...     List of plot names
  -opacity             Opacity for plots
  -random <n [n [n]]>
                       Generate a random SVG with: #plots [max
                       value [min value]]
  -reserve <n [n [n [n]]]>
                       Reserved space on the left [top [right
                       [bottom]]]
  -rows                Group data by rows
  -scattered <bitmap¹>
                       Plots to show as scatter plots
  -semi                Use semicolons to seperate columns
  -shapes <shape>...   List of shapes to use
  -showpoints <bitmap¹>
                       Data plots with points
  -size <n>            Base font size
  -smooth <n>          EMA smoothing, 0 means none
  -sortx               Sort points by the x values before
                       plotting
  -stroke <n>          Stroke width
  -subheader <n>       Sub-title row or column source
  -subtitle <text>     Sub-title
  -textcolour <colour>
                       Foreground text colour
   aka: textcolor
  -title <text>        Chart title
  -tsv                 Use tabs to seperate columns
  -verbose             Add extra information
  -width <n>           Chart width
  -xmax <n>            Abscissa maximum
  -xmin <n>            Abscissa minimum
  -xtags <n>           Row or column with abscissa tags
  -xtick <n>           Distance between abcissa ticks
  -ymax <n>            Ordinate maximum
  -ymin <n>            Ordinate minimum
  -ytick <n>           Distance between ordinate ticks
```
```
Canvas specific options:
  -canvas <name>       Canvas name
  -tag <file>          File to write canvas tag to
```
```
SVG specific options:
  -css <file>          Include file for css styling
  -cssid <id>          CSS id for <SVG> tag
  -hover               Add CSS code to emphasize hovered plots,
                       nohover to not add
  -svg <file>          Include file for svg elements
```
```
Help specific options:
  -indent <n>          Indent for option usage
  -left <n>            Left margin for help text
  -right <n>           Right margin for text
  -usage <n>           Left margin for option usage
```
```
¹ <bitmap> means a series of plot numbers like '1 2 3 4'
Negative numbers forms the upper bound on a range, '1 -4' is
the same as '1 2 3 4'. The first number defaults to 1 so in
fact '-4' is all that is needed.
The word 'all' means all i.e. '1 -64'
The list must be terminated by a '--', either as a long
argument or a literal '--'.
```
