# Settings

The settings file is [JSON](https://en.wikipedia.org/wiki/JSON) encoded and the following
tags are supported, the data type and default value are shown in parathenses. Some values can be set from the command line and these are shown.

#### backgroundColour (Colour) <sup>[9](#fn9)</sup>
- **Command Line Option:** `--bg`
- **Environment variable:** `CSV2_BACKGROUND_COLOUR`

The background colour for the chart.

#### bared (BitMap)
- **Command Line Option:** `--bared`
- **Default value**: `none`

A bit vector of the plots to draw as bars.<sup>[5](#fn5)</sup>

#### barOffset (Int)
- **Command Line Option:** `--baroffset`
- **Default value**: `-1`

The offset of each bar from the adjacent one.<br/>
If it is less than 0 then it is calculated.

#### barWidth (Int)
- **Command Line Option:** `--barwidth`
- **Default value**: `1`

The width of each bar.<br/>
If it is less than or equal to 0 then it is calculated.

#### baseFontSize (Double)
- **Command Line Option:** `--size`
- **Default value**: `10`
- **Environment variable:** `CSV2_BASE_FONT_SIZE`

The base font size for the chart, all other font sizes are derived from this value.

#### bezier (Double `0.0`)
- **Allowed values:** From `0.0` to `0.5`
- **Command Line Option:** `--bezier`
- **Default value**: `0.0`
- **Environment variable:** `CVS2_BEZIER`

Each join is converted to a quadratic Bézier curve. The `bezier` value determines where
the curve begins and ends, e.g. setting it to .25 means that the curve starts at 25% of
the way from the current point to the previous point and ends 25% of the way to the next
point. The current point becomes the control point. If showDataPoints is set then the actual datapoint is shown. Setting this to more than .5 or less than 0 isn't going to
produce anything readable and is normally prohibited.

#### black (Bool)
- **Command Line Option:** `--black`
- **Default value**: `false`

Set undefined plot colours to "black"

#### bold (Bool)
- **Command Line Option:** `--bold`
- **Default value**: `false`

Use bold text.

#### bounded (Bool)
- **Command Line Option:** `--bounds` <sup>[8](#fn8)</sup>
- **Default value**: `true`
- **Environment variable:** `CVS2_BOUNDS` <sup>[10](#fn10)</sup>

Bounds check some parameters

#### canvas (String) <sup>[canvas only](#fncanvas)</sup>
- **Command Line Option:** `--canvas`

The id of the canvas to write to.

#### colours (Array of Strings) <sup>[9](#fn9)</sup>
- **Command Line Option:** `--colours`<sup>[6](#fn6)</sup>

The colours to be used to plot the column or row. The index, if present, must be included
although never used. Columns or rows that aren't defined are assigned a colour sequentially from an internal list.<br/>
More on colours can be found [here](colours.md).

#### comment (Bool)
- **Command Line Option:** `--comment` <sup>[8](#fn8)</sup>
- **Default value**: `true`

Add an identifying comment to the chart.

#### cssClasses (Array of Strings) <sup>[svg only](#fnsvg)</sup>

The elements of the SVG use CSS for styling with each plot having it's own class. The
classes in this list are assigned to each row or column in turn including the index. Plots
not included in this list are assigned an automatically generated class.<br/>
There are no restrictions on the contents so that multiple classes can be attached to a
plot by using a space seperated list for each entry.<br/>
For more information see (css.md)[css.md]

#### cssExtras (Array of Strings)</a> <sup>[svg only](#fnsvg)</sup>

The strings in this array are copied into a `<style>` tag.

#### cssID (String) <sup>[svg only](#fnsvg)</sup>
- **Command Line Option:** `--cssid`

The style tags of SVG's can affect each other when they are included in an HTML document. For this reason every `<svg>` tag has an `id` defined. It can be this id or a random one. If the `cssID` is set to _"none"_ then no id is added to the SVG.

#### cssInclude (String) <sup>[svg only](#fnsvg)</sup>
- **Command Line Option:** `--css`

The contents of the file named by this string are included in a separate `<style>` tag.

#### dashedLines (BitMap)
- **Command Line Option:** `--dashed`

A bit vector of the plots to draw as dashed lines.<sup>[5](#fn5)</sup>

#### dashes (Array of Strings)
- **Command Line Option:** `--dashes`<sup>[6](#fn6)</sup>

The dash patterns to be used to plot the column or row. These are a list of numbers separated by either a space or a comma.
Each string forms one dash e.g. `--dashes 1,2,3 "4 5 6"` defines 2 dash patterns.
See[this article](https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/stroke-dasharray)
for more details.
The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a pattern sequentially from an internal list.

#### dataPointDistance (Double)
- **Command Line Option:** `--distance`
- **Default value**: `10.0`

The minimum number of pixels between adjacent data points.

#### draft (Bool)
- **Command Line Option:** `--draft`
- **Default value**: `false`

Display *draftText*

#### draftText (String)
- **Command Line Option:** `--draft`
- **Default value**: `DRAFT`

The message to display if the chart is a draft.<br/>
The option `--draft` can also set the text by following it with an argument.

#### filled (BitMap)
- **Command Line Option:** `--filled`
- **Default value**: `none`

A bit vector of the plots to draw filled.<sup>[5](#fn5)</sup>

#### fontFamily (String)
- **Command Line Option:** `--font`
- **Environment variable:** `CVS2_FONT_FAMILY`

The font family to use for text.

#### foregroundColours (Dictionary of Colours) <sup>[9](#fn9)</sup>
- **Default value**: `black`
- **Command Line Option:** `--fg`
- **Environment variable:** `CSV2_FOREGROUND_COLOUR`
- **Command Line Option:** `--textcolour`
- **Environment variable:** `CSV2_TEXT_COLOUR`

The colours of the elements on the chart separate from the plots can be set using the
foregroundColours dictionary. Colours that aren't defined are set to the options above `--texrcolour` sets the text and  `--fg` sets the rest. The keys for the dictionary are:

- **axes**: sets the colours for the abscissa, ordinate and grid. The grid has a lower alpha value making it appear lighter.
- **draft**: the colour for the draft text.
- **legends**: the colour for the word "Legends".
- **legendsBox**: the box around the legends where once again the alpha is lowered.
- **pieLabel**: the text beside pie slices, its default is a less opaque pieLegend.
- **pieLegend**: the text under pie charts.
- **subTitle**: the text under the title.
- **title**: the title.
- **xLabel**: the value markers for the abscissa.
- **xTags**: the extra markers for the abscissa.
- **xTitle**: the text describing the abscissa.
- **yLabel**: the value markers for the ordinate.
- **yTitle**:  the text describing the ordinate.

#### headerColumns (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--headers`<sup>[4](#fn4)</sup>
- **Default value**: `0`

The number of columns that do not contain data.<sup>[1](#fn1)</sup>

#### headerRows (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--headers`<sup>[4](#fn4)</sup>
- **Default value**: `0`

The number of rows that do not contain data.<sup>[1](#fn1)</sup>

#### height (Int)
- **Command Line Option:** `--height`
- **Default value**: `600`
- **Environment variable:** `CSV2_HEIGHT`

The height of the generated Canvas or SVG

#### hover (Bool) <sup>[svg only](#fnsvg)</sup>
- **Command Line Option:** `--hover` <sup>[8](#fn8)</sup>
- **Default value**: `true`

Add the css to emphasize the hovered over plot.

#### include (BitMap)
- **Command Line Option:** `--include`
- **Default value**: `all`

A bit vector of the plots to draw.<sup>[5](#fn5)</sup><br/>

#### index (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--index`
- **Default value**: `0`

The column or row that contains the absissa data with the leftmost column or top row
being 1.<br/>
If it is less than or equal to zero then the absica is 0 for the first value of each plot and so on.

#### italic (Bool)
- **Command Line Option:** `--italic`
- **Default value**: `false`

Use italic text.

#### legends (Bool)
- **Command Line Option:** `--legends` <sup>[8](#fn8)</sup>
- **Default value**: `true`

Add the legends panel if there is room.

#### logoHeight (Int)
- **Default value**: `64`

The height of the logo `<image>` element.

#### logoURL (URL)
- **Command Line Option:** `--logo`
- **Environment variable:** `CSV2_LOGO_URL`

The URL of an image to include in the top right corner of the plot. By default the logo
element is 64x64 but this can be changed.
Other sized images are scaled to fit while preserving the aspect ratio and fitting the top
right corner of the image in the top right corner of the plot.

#### logoWidth (Int)
- **Default value**: `64`

The width of the logo `<image>` element.

#### logx (Bool)
- **Command Line Option:** `--logx`
- **Default value**: `false`

The abcissa uses a logarithmic scale

#### logy (Bool)
- **Command Line Option:** `--logy`
- **Default value**: `true`

The ordinate uses a logarithmic scale

#### nameHeader (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--nameheader`
- **Default value**: `1`

The row or column that contains the names of plots. If it is less than or equal to zero
the the name is never fetched from the csv.

#### names (Array of Strings)
- **Command Line Option:** `--names`<sup>[6](#fn6)</sup>

The plotted columns or rows are assigned names from this array or the first header row or
column respectively. If not defined in either place then a name is generated.
The names are included with the colours associated with the plots in the legends area.

#### opacity (Double)
- **Allowed values:** From 0 to 1.0
- **Command Line Option:** `--opacity`
- **Default value**: `1.0`

The opacity of the plots.

#### pdf (Dictionary of Strings) <sup>[pdf](#fnpdf)</sup>
Some of the pdf attributes can be defined here:

- **author**: the author of the chart.
- **keywords**: a list of keywords separated by `;`
- **subject**: the subject of the chart.
- **title**: the title of the chart,
if this is not specified then the chart `title` is used if defined.

#### pieLabel (Bool) <sup>[pie](#fnpie)</sup>
- **Default value**: `false`

Display the percentage of each slice unless the slice is too small.

#### pieSubLegend (Bool) <sup>[pie](#fnpie)</sup>
- **Default value**: `false`

Display the total under the pie chart legend, see [xTagsHeader](#xtags) below.

#### pieSubLegendPrefix (String) <sup>[pie](#fnpie)</sup>

Text to add before the total on the sub legend line.

#### pieSubLegendSuffix (String) <sup>[pie](#fnpie)</sup>

Text to add after the total on the sub legend line.

#### reserveBottom** (Double)
- **Command Line Option:** `--reserve`<sup>[7](#fn7)</sup>
- **Default value**: `0.0`

Reserve space on the bottom of the Canvas or SVG

#### reserveLeft (Double)
- **Command Line Option:** `--reserve`<sup>[7](#fn7)</sup>
- **Default value**: `0.0`

Reserve space on the left side of the Canvas or SVG

#### reserveRight (Double)
- **Command Line Option:** `--reserve`<sup>[7](#fn7)</sup>
- **Default value**: `0.0`

Reserve space on the right side of the Canvas or SVG

#### reserveTop (Double)
- **Command Line Option:** `--reserve`<sup>[7](#fn7)</sup>
- **Default value**: `0.0`

Reserve space on the top of the Canvas or SVG

#### rowGrouping (Bool)
- **Command Line Option:** `--rows`<br/>
- **Default value**: `false`

The data is grouped in rows

#### scatterPlots (BitMap)
- **Command Line Option:** `--scattered`
- **Default value**: `none`

A bit vector of the plots to draw as scatter plots.<sup>[5](#fn5)</sup>

#### shapes (Array of Strings)
- **Command Line Option:** `--shapes`<sup>[6](#fn6)</sup>

A list of shape names to be used in scatter plots and when showing data points.
The names are taken sequentially from the list and assigned to plots. If there are too few
shape names or they cannot be looked up then a shape from an internal list is assigned.

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

#### showDataPoints (BitMap)
- **Command Line Option:** `--datapoints`
- **Command Line Option:** `--pointed`
- **Command Line Option:** `--showpoints`
- **Default value**: `none`

A bit vector of the plots to draw with data points.<sup>[5](#fn5)</sup>

#### smooth (Double)
- **Allowed values:** From 0.0 to 0.99
- **Command Line Option:** `--smooth`
- **Default value**: `0.0`

Smooth the ordinate values using an
[Exponential Moving Average](https://en.wikipedia.org/wiki/Moving_average#Exponential_moving_average)
The value for smooth is actually `1 - α` as it makes more sense to me for no smoothing to be `0.0` rather than `1.0`.

#### sortx (Bool)
- **Command Line Option:** `--sortx`
- **Default value**: `false`

Sort the points based on the x value before plotting.

#### strokeWidth (Double)
- **Allowed values:** From 0 to 100
- **Command Line Option:** `--stroke`
- **Default value**: `2.0`
- **Environment variable:** `CSV2_STROKE_WIDTH`

The width of the plotted paths

#### subTitle (String)
- **Command Line Option:** `--subtitle`

The sub-title attached to the Canvas or SVG

#### subTitleHeader (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--subheader`
- **Default value**: `0`

The row or column that contains the sub-title. If it is less than or equal to zero
the the name is never fetched from the csv. If the sub-title is defined by the option
above then the csv is not checked. Embedded commas will probably cause problems.

#### svgInclude (String) <sup>[svg only](#fnsvg)</sup>
- **Command Line Option:** `--svg`

This options is the path of a file to include at the end the SVG, just before the `</svg>`

#### tagFile** (String) <sup>[canvas only](#fncanvas)</sup>
- **Command Line Option:** `--tag`

Name of the file to receive the `<canvas>` tag that the generated JavaScript expects to
use.

#### tagFile** (String) <sup>[pdf only](#fnpdf)</sup>
- **Command Line Option:** `--tag`

Name of the file to receive the `<object>` tag that can be use to embed the pdf in
an HTML file.

#### title** (String)
- **Command Line Option:** `--title`

The title attached to the chart

#### width (Int)
- **Command Line Option:** `--width`
- **Environment variable:** `CSV2_WIDTH`

The width of the generated chart.

#### xMax (Double)
- **Command Line Option:** `--xmax`
- **Default value**: `-inf`

The maximum value for the abscissa.<sup>[2](#fn2)</sup>

#### xMin** (Double)
- **Command Line Option:** `--xmin`
- **Default value**: `inf`

The minimum value for the abscissa.<sup>[2](#fn2)</sup>

#### xTagsHeader (Int)
- **Allowed values:** From 0 to 25
- **Command Line Option:** `--xtags`
- **Default value**: `0`

The row or column containing the extra tags to be displayed below the plot area.<br/>
For pie charts this is the column that contains the text displayed below each chart.

#### xTick (Double)
- **Default value**: `0.0`

How often to print the abscissa values and draw a line.<sup>[3](#fn3)</sup>

#### xTitle (String)

The title attached to the abscissa.

#### yMax (Double)
- **Command Line Option:** `--ymax`
- **Default value**: `-inf`

The maximum value for the ordinate.<sup>[2](#fn2)</sup>

#### yMin (Double)
- **Command Line Option:** `--ymin`
- **Default value**: `inf`

The minimum value for the ordinate.<sup>[2](#fn2)</sup>

#### yTick (Double)
- **Default value**: `0.0`

How often to print the ordinate values and draw a line.

#### yTitle (String)

the title attached to the ordinate

### Footnotes

- <a id="fn1">1</a>: header columns or rows are used to name the path plotted.

- <a id="fn2">2</a>: if not defined the min and max are taken from the data.

- <a id="fn3">3</a>: setting this to -1 will remove the ticks.

- <a id="fn4">4</a>: `--headers` will set both headerColumns and headerRows

- <a id="fn5">5</a>:  a bit vector is a list of plot numbers like '1 2 3 4' corresponding to the rows or columns
Negative numbers forms the upper bound on a range, '1 -4' is the same as '1 2 3 4'. The first number is initially 1 so in
fact '-4' is all that is needed.

- <a id="fn6">6</a>: These options accept a list of words separated by spaces up until the next flag
or option. If there are none before the file names then a `--` can be used to terminate the list.

- <a id="fn7">7</a>: Although there are 4 parameters there is only one command line option. The option can
have between 1 and 4 values, these values are assigned to the sides in turn.<br/>
Hence `--reserve 1 2 3 4` is the same as `reserveLeft: 1`, `reserveTop: 2`, `reserveRight 3` and,
`reserve Bottom: 4`.

- <a id="fn8">8</a>: The command line arguments are the opposite of the JSON settings, `--noxxx` sets
`xxx` to `false`.

- <a id="fn9">9</a>: Specifying colours is covered [here](colours.md)

- <a id="fn10">10</a>: Boolean values must be defined in environment variables:
    - `true`: "true", "yes" or, "1"
    - `false`: "false", "no" or "0"
    - anything else will cause an error

- <a id="fncanvas">canvas</a>: Only when creating a Canvas plot

- <a id="fnpdf">pdf</a>: Only when creating a PDF chart

- <a id="fnpie">pie</a>: Only when creating a Pie chart

- <a id="fnsvg">svg</a>: Only when creating an SVG plot
