# Settings

The settings file is [JSON](https://en.wikipedia.org/wiki/JSON) encoded and the following
tags are supported, the data type and default value are shown in parathenses. Some values can be set from the command line and these are shown.

**backgroundColour** (String) <sup>[9](#fn9)</sup><br/>
**Option:**`--bg`<br/>
The background colour for the Canvas or SVG

**bared** (Int **0**)<br/>
**Option:** `--bared`<br/>
A bit vector of the plots to draw as bars.<sup>[5](#fn5)</sup>

**barOffset** (Int **-1**)<br/>
**Option:** `--baroffset`<br/>
The offset of each bar from the adjacent one.<br/>
If it is less than 0 then it is calculated.

**barWidth** (Int **1**)<br/>
**Option:** `--barwidth`<br/>
The width of each bar.<br/>
If it is less than or equal to 0 then it is calculated.

**baseFontSize** (Double **10.0**)<br/>
**Option:** `--size`<br/>
The base font size for the Canvas or SVG, all other font sizes are derived from this value

**bezier** (Double **0.0**)<br/>
**Option:** `--bezier`<br/>
**Allowed values:** From 0 to 0.5
Each join is converted to a quadratic Bézier curve. The `bezier` value determines where the curve begins and ends,
e.g. setting it to .25 means that the curve starts at 25% of the way from the current point to the previous point and ends
25% of the way to the next point. The current point becomes the control point. If showDataPoints is set then the actual
datapoint is shown. Setting this to more than .5 or less than 0 isn't going to produce anything readable.

**black** (Bool **false**)<br/>
**Option:** `--black`<br/>
Set undefined plot colours to "black"

**bold** (Bool **false**)<br/>
**Option:** `--bold`<br/>
Use bold text.

**bounded** (Bool **true**)<br/>
**Option:** `--nobounds` <sup>[8](#fn8)</sup><br/>
Bounds check some parameters

**canvas** (String)<sup>[canvas](#fncanvas)</sup><br/>
**Option:** `--canvas`<br/>
The id of the canvas to write to.

**colours** (Array of Strings) <sup>[9](#fn9)</sup><br/>
**Option:** `--colours`<sup>[6](#fn6)</sup><br/>
The colours to be used to plot the column or row. The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a colour sequentially from an internal list.
More on colours can be found [here](colours.md).

**comment** (Bool **true**)<br/>
**Option:** `--nocomment` <sup>[8](#fn8)</sup><br/>
Add an identifying comment to the SVG

<a id="cssClasses">**cssClasses** (Array of Strings)</a><sup>[svg](#fnsvg)</sup><br/>
The elements of the SVG use CSS for styling with each plot having it's own class. The classes in this list are assigned
to each row or column in turn including the index. Plots not included in this list are assigned an automatically generated class.<br/>
There are no restrictions on the contents so that multiple classes can be attached to a plot by using a space seperated list for
each entry.<br/>
For more information see (css.md)[css.md]

<a id="cssExtras">**cssExtras** (Array of Strings)</a><sup>[svg](#fnsvg)</sup><br/>
The strings in this array are copied into a `<style>` tag.

<a id="cssID">**cssID** (String)</a><sup>[svg](#fnsvg)</sup><br/>
**Option:** `--cssid`<br/>
The style tags of SVG's can affect each other when they are included in an HTML document. For this reason every `<svg>` tag
has an `id` defined. It can be this id or a random one. If the `cssID` is set to _"none"_ then no id is added to the SVG.

<a id="cssInclude">**cssInclude** (String)</a><sup>[svg](#fnsvg)</sup><br/>
**Option:** `--css`<br/>
The contents of the file named by this string are included in a separate `<style>` tag.

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
The minimum number of pixels between adjacent data points.

**filled** (Int **0**)<br/>
**Option:** `--filled`<br/>
A bit vector of the plots to draw filled.<sup>[5](#fn5)</sup>

**fontFamily** (String)<br/>
**Option:** `--font`<br/>
The font family to use for text.

**foregroundColours** (Dictionary of Strings) <sup>[9](#fn9)</sup><br/>
**Option:** `--fg`<br/>
**Option:** `--textcolour`<br/>
The colours of the elements on the chart separate from the plots can be set using the foregroundColours dictionary.
Colours that aren't defined are set to the options above `--texrcolour` sets the text and  `--fg` sets the rest. The
keys for the dictionary are:

- **axes**: sets the colours for the abscissa, ordinate and grid. The grid has a lower alpha value making it appear lighter.
- **legends**: the colour for the word "Legends".
- **legendsBox**: the box around the legends where once again the alpha is lowered.
- **pieLegend**: the text under pie charts.
- **subTitle**: the text under the title.
- **title**: the title.
- **xLabel**: the value markers for the abscissa.
- **xTags**: the extra markers for the abscissa.
- **xTitle**: the text describing the abscissa.
- **yLabel**: the value markers for the ordinate.
- **yTitle**:  the text describing the ordinate.

**headerColumns** (Int **0**)<br/>
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
**Allowed values:** From 0 to 25
The number of columns that do not contain data.<sup>[1](#fn1)</sup>

**headerRows** (Int **0**)<br/>
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
**Allowed values:** From 0 to 25
The number of rows that do not contain data.<sup>[1](#fn1)</sup>

**height** (Int **600**)<br/>
**Option:** `--height`<br/>
The height of the generated Canvas or SVG

**hover** (Bool **true**)<sup>[svg](#fnsvg)</sup><br/>
**Option:** `--nohover` <sup>[8](#fn8)</sup><br/>
Add the css to emphasize the hovered over plot.

**include** (Int **-1**)<br/>
**Option:** `--include`<br/>
A bit vector of the plots to draw.<sup>[5](#fn5)</sup><br/>
The default is to draw all.

**index** (Int **0**)<br/>
**Option:** `--index`<br/>
**Allowed values:** From 0 to 25
The column or row that contains the absissa data with the leftmost column or top row being 1.<br/>
If it is less than or equal to zero then the absica is 0 for the first value of each plot and so on.

**italic** (Bool **false**)<br/>
**Option:** `--italic`<br/>
Use italic text.

**legends** (Bool **true**)<br/>
**Option:** `--nolegends` <sup>[8](#fn8)</sup><br/>
Add the legends panel if there is room.

**logoHeight** (Int **64**)<br/>
The height of the logo `<image>` element.

<a id="logoURL">**logoURL** (String)</a><br/>
**Option:** `--logo`<br/>
The URL of an image to include in the top right corner of the plot. By default the logo
element is 64x64 but this can be changed.
Other sized images are scaled to fit while preserving the aspect ratio and fitting the top right
corner of the image in the top right corner of the plot.

**logoWidth** (Int **64**)<br/>
The width of the logo `<image>` element.

**logx** (Bool **false**)<br/>
**Option:** `--logx`<br/>
The abcissa uses a logarithmic scale

**logy** (Bool **false**)<br/>
**Option:** `--logy`<br/>
The ordinate uses a logarithmic scale

**nameHeader** (Int **1**)<br/>
**Option:** `--nameheader`<br/>
**Allowed values:** From 0 to 25
The row or column that contains the names of plots. If it is less than or equal to zero
the the name is never fetched from the csv.

**names** (Array of Strings)<br/>
**Option:** `--names`<sup>[6](#fn6)</sup><br/>
The plotted column or rows are assigned names from this array or the first header row or column respectively. If not defined in either place then a name is generated.
The names are included with the colours associated with the plots under the plot area.

**opacity** (Double **1.0**)<br/>
**Option:** `--opacity`<br/>
**Allowed values:** From 0 to 1.0
The opacity of the plots.

**reserveBottom** (Double **0.0**)<br/>
**Option:** `--reserve`<sup>[7](#fn7)</sup><br/>
Reserve space on the bottom of the Canvas or SVG

**reserveLeft** (Double **0.0**)<br/>
**Option:** `--reserve`<sup>[7](#fn7)</sup><br/>
Reserve space on the left side of the Canvas or SVG

**reserveRight** (Double **0.0**)<br/>
**Option:** `--reserve`<sup>[7](#fn7)</sup><br/>
Reserve space on the right side of the Canvas or SVG

**reserveTop** (Double **0.0**)<br/>
**Option:** `--reserve`<sup>[7](#fn7)</sup><br/>
Reserve space on the top of the Canvas or SVG

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
1. ![blade](blade.svg) blade
1. ![circle](circle.svg) circle
1. ![circle star](circleStar.svg) circleStar
1. ![cross](cross.svg) cross
2. ![diamond](diamond.svg) diamond
2. ![shuriken](shuriken.svg) shuriken
3. ![square](square.svg) square
4. ![star](star.svg) star
5. ![triangle](triangle.svg) triangle

**showDataPoints** (Int **0**)<br/>
**Option:** `--datapoints`<br/>
A bit vector of the plots to draw with data points.<sup>[5](#fn5)</sup>

**smooth** (Double **0.0**)<br/>
**Option:** `--smooth`<br/>
**Allowed values:** From 0 to 0.99
Smooth the ordinate values using an
[Exponential Moving Average](https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average)
The value for smooth is actually `1 - α` as it makes more sense to me for no smoothing to be `0.0` rather than `1.0`.

**sortx** (Bool **false**)<br/>
**Option:** `--sortx`<br/>
Sort the points based on the x value before plotting.

<a id="strokeWidth">**strokeWidth** (Double **2.0**)</a><br/>
**Option:** `--stroke`<br/>
**Allowed values:** From 0 to 100
The width of the plotted paths

**subTitle** (String)<br/>
**Option:** `--subtitle`<br/>
The sub-title attached to the Canvas or SVG

**subTitleHeader** (Int **0**)<br/>
**Option:** `--subheader`<br/>
**Allowed values:** From 0 to 25
The row or column that contains the sub-title. If it is less than or equal to zero
the the name is never fetched from the csv. If the sub-title is defined by the option
above then the csv is not checked. Embedded commas will probably cause problems.<br/>
**N.B.** leading and trailing double quotes and spaces are stripped from csv data when
it is read, they have no effect on how the data is interpreted.

<a id="svgInclude">**svgInclude** (String)</a><sup>svg(#fnsvg)</sup><br/>
**Option:** `--svg`<br/>
This options is the path of a file to include at the end the SVG, just before the `</svg>`

**title** (String)<br/>
**Option:** `--title`<br/>
The title attached to the Canvas or SVG

**width** (Int **800**)<br/>
**Option:** `--width`<br/>
The width of the generated Canvas or SVG.

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

- <a id="fn1">1</a>: header columns or rows are used to name the path plotted.

- <a id="fn2">2</a>: if not defined the min and max are taken from the data.

- <a id="fn3">3</a>: setting this to -1 will remove the ticks.

- <a id="fn4">4</a>: `--headers` will set both headerColumns and headerRows

- <a id="fn5">5</a>: A bit vector is an integer where each bit represents a plot
e.g. _25 == 2<sup>4</sup> + 2<sup>3</sup> + 2<sup>0</sup>_ which would mean that the
fifth, fourth and first row or column would be enabled. A value of -1 means all plots.<br/>
To simplify the calculation the `--bitmap` option can be used e.g.<br/>
`csv2 --bitmap 5 4 1` gives `25`.

- <a id="fn6">6</a>: These options accept a list of words separated by spaces up until the next flag
or option. If there are none before the file names then a `--` can be used to terminate the list.

- <a id="fn7">7</a>: Although there are 4 paramaters there is only one command line option. The option can
have between 1 and 4 values, these values are assigned to the sides in turn.<br/>
Hence `--reserve 1 2 3 4` is the same as `reserveLeft: 1`, `reserveTop: 2`, `reserveRight 3` and,
`reserve Bottom: 4`.

- <a id="fn8">8</a>: The command line arguments are the opposite of the JSON settings, `--noxxx` sets
`xxx` to `false`.

- <a id="fn9">9</a>: Specifying colours is covered [here](colours.md)

- <a id="fncanvas">canvas</a>: Only when creating a Canvas plot

- <a id="fnsvg">svg</a>: Only when creating an SVG plot
