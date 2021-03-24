# Settings

The settings file is [JSON](https://en.wikipedia.org/wiki/JSON) encoded and the following
tags are supported, the data type and default value are shown in parathenses. Some default values can be set from the command line and these are shown however these are overridden by the JSON file settings.

**backgroundColour** (String)<br/>
**Option:**`--bg`<br/>
The background colour for the svg

**baseFontSize** (Double **10.0**)<br/>
**Option:** `--size`<br/>
The base font size for the SVG, all other font sizes are derived from this value

**black** (Bool **false**)<br/>
**Option:** `--black`<br/>
Set undefined plot colours to "black"

**bold** (Bool **false**)<br/>
**Option:** `--bold`<br/>
Use bold text.

**colours** (Array of Strings)<br/>
**Option:** `--colours`<sup>[6](#fn6)</sup><br/>
The colours to be used to plot the column or row. The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a colour sequentially from an internal list.

**dashedLines** (Int **0**)<br/>
**Option:** `--dashed`<br/>
A bit vector of the plots to draw as dashed lines.<sup>[5](#fn5)</sup>

**dashes** (Array of Strings)<br/>
**Option:** `--dashes`<sup>[6](#fn6)</sup><br/>
The dash patterns to be used to plot the column or row. These are a list of numbers seperated by either a space or a comma.
Each string forms one dash e.g. `--dashes 1,2,3 "4 5 6"` defines 2 dash patterns.
[See](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-dasharray) for more details.
The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a pattern sequentially from an internal list.

**dataPointDistance** (Double **10.0**)<br/>
**Option:** `--distance`<br/>
The minimum number of pixels between adjacent data points

**fontFamily** (String)<br/>
**Option:** `--font`<br/>
The font family to use for text.

**headerColumns** (Int **0**)<br/>
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
The number of columns that do not contain data.<sup>[1](#fn1)</sup>

**headerRows** (Int **0**)<br/>
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
The number of rows that do not contain data.<sup>[1](#fn1)</sup>

**height** (Int **600**)<br/>
**Option:** `--height`<br/>
The height of the generated SVG

**include** (Int **-1**)<br/>
**Option:** `--include`<br/>
A bit vector of the plots to draw.<sup>[5](#fn5)</sup><br/>
The default is to draw all.

**index** (Int **0**)<br/>
**Option:** `--index`<br/>
The column or row that contains the absissa data with the leftmost column or top row being 1.<br/>
If it is less than or equal to zero then the absica is 0 for the first value of each plot and so on.

**italic** (Bool **false**)<br/>
**Option:** `--italic`<br/>
Use italic text.

**logx** (Bool **false**)<br/>
**Option:** `--logx`<br/>
The abcissa uses a logarithmic scale

**logy** (Bool **false**)<br/>
**Option:** `--logy`<br/>
The ordinate uses a logarithmic scale

**nameHeader** (Int **1**)<br/>
**Option:** `--nameheader`<br/>
The row or column that contains the names of plots. If it is less than or equal to zero
the the name is never fetched from the csv.

**names** (Array of Strings)<br/>
**Option:** `--names`<sup>[6](#fn6)</sup><br/>
The plotted column or rows are assigned names from this array or the first header row or column respectively. If not defined in either place then a name is generated.
The names are included with the colours associated with the plots under the plot area.

**rowGrouping** (Bool **false**)<br/>
**Option:** `--rows`<br/>
The data is grouped in rows

**scatterPlots** (Int **0**)<br/>
**Option:** `--scattered`<br/>
A bit vector of the plots to draw as scatter plots.<sup>[5](#fn5)</sup>

**shapes** (Array of Strings)<br/>
**Option:** `--shapes`<sup>[6](#fn6)</sup><br/>
A list of shape names to be used in scatter plots. The names are taken sequentially from
the list and assigned to scatter plots. If there are too few shape names or they cannot be
looked up the a shape from an internal list is assigned.

Recognized names are:
1. ![blade](shapes/blade.svg) blade
1. ![circle](shapes/circle.svg) circle
2. ![diamond](shapes/diamond.svg) diamond
2. ![shuriken](shapes/shuriken.svg) shuriken
3. ![square](shapes/square.svg) square
4. ![star](shapes/star.svg) star
5. ![triangle](shapes/triangle.svg) triangle

**showDataPoints** (Int **0**)<br/>
**Option:** `--datapoints`<br/>
A bit vector of the plots to draw with data points.<sup>[5](#fn5)</sup>

**smooth** (Double **0.0**)<br/>
**Option:** `--smooth`<br/>
Smooth the ordinate values using an
[Exponential Moving Average](https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average)
The value for smooth is actually `1 - α` as it makes more sense to me for no smoothing to be `0.0` rather than `1.0`.

**sortx** (Bool **false**)<br/>
**Option:** `--sortx`<br/>
Sort the points based on the x value before plotting.

**strokeWidth** (Double **2.0**)<br/>
**Option:** `--stroke`<br/>
The width of the plotted paths

**subTitle** (String)<br/>
**Option:** `--subtitle`<br/>
The sub-title attached to the SVG

**subTitleHeader** (Int **0**)<br/>
**Option:** `--subheader`<br/>
The row or column that contains the sub-title. If it is less than or equal to zero
the the name is never fetched from the csv. If the sub-title is defined by the option
above then the csv is not checked. Embedded commas will probably cause problems.<br/>
**N.B.** leading and trailing double quotes and spaces are stripped from csv data when
it is read, they have no effect on how the data is interpreted.

**title** (String)<br/>
**Option:** `--title`<br/>
The title attached to the SVG

**width** (Int **800**)<br/>
**Option:** `--width`<br/>
The width of the generated SVG.

**xMax** (Double **-inf**)<br/>
**Option:** `--xmax`<br/>
The maximum value for the abscissa.<sup>[2](#fn2)</sup>

**xMin** (Double **inf**)<br/>
**Option:** `--xmin`<br/>
The minimum value for the abscissa.<sup>[2](#fn2)</sup>

**xTick** (Double **0**)<br/>
How often to print the abscissa values and draw a line.<sup>[3](#fn3)</sup>

**xTitle** (String)<br/>
The title attached to the abscissa.

**yMax** (Double **-inf**)<br/>
**Option:** `--ymax`<br/>
The maximum value for the ordinate.<sup>[2](#fn2)</sup>

**yMin** (Double **inf**)<br/>
**Option:** `--ymin`<br/>
The minimum value for the ordinate.<sup>[2](#fn2)</sup>

**yTick** (Int **0**)<br/>
How often to print the ordinate values and draw a line.

**yTitle** (String)<br/>
the title attached to the ordinate

### Footnotes

<a id="fn1">1</a>: header columns or rows are used to name the path plotted.

<a id="fn2">2</a>: if not defined the min and max are taken from the data.

<a id="fn3">3</a>: setting this to -1 will remove the ticks.

<a id="fn4">4</a>: `--headers` will set both headerColumns and headerRows

<a id="fn5">5</a>: A bit vector is an integer where each bit represents a plot
e.g. _25 == 2<sup>4</sup> + 2<sup>3</sup> + 2<sup>0</sup>_ which would mean that the
fifth, fourth and first row or column would be enabled. A value of -1 means all plots.<br/>
To simplify the calculation the `--bitmap` option can be used e.g.<br/>
`csv2svg --bitmap 5 4 1` gives `25`.

<a id="fn6">6</a>: These options accept a list of words separated by spaces up until the next flag
or option. 
If there are none before the file names then a `--` can be used to terminate the list.
