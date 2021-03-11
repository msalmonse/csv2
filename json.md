# Settings

The settings file is [JSON](https://en.wikipedia.org/wiki/JSON) encoded and the following
tags are supported, the data type and default value are shown in parathenses. Some default values can be set from the command line and these are shown however these are overridden by the JSON file settings.

#### backgroundColour (String)
**Option:**`--bg`<bg/>
The background colour for the svg

#### baseFontSize (Double _10.0_)
**Option:** `--size`<br/>
The base font size for the SVG, all other font sizes are derived from this value

#### black (Bool _false_)
**Option:** `--black`<br/>
Set undefined plot colours to "black"

#### colours (Array of Strings)
The colours to be used to plot the column or row. The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a colour sequentially from an internal list.

#### headerColumns (Int _0_)
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
The number of columns that do not contain data.<sup>[1](#fn1)</sup>

#### headerRows (Int _0_)
**Option:** `--headers`<sup>[4](#fn4)</sup><br/>
The number of rows that do not contain data.<sup>[1](#fn1)</sup>

#### height (Int _600_)
**Option:** `--height`</br>
The height of the generated SVG

#### index (Int _0_)
**Option:** `--index`<br/>
The column or row that contains the absissa data with the leftmost column or top row being 1.<br/>
If it is less than or equal to zero then the absica is 0 for the first vale of each plot and so on.

#### names (Array of Strings)
The plotted column or rows are assigned names from this array or the first header row or column respectively.
The name are included with the colours associated with the plots.

#### rowGrouping (Bool _false_)
**Option:** `--rows`<br/>
The data is grouped in rows

#### scatterPlots (Int _0_)
**Option:** `--scattered`<br/>
A bit vector of the plots to draw as a scatter plot.
e.g. _25 == 2<sup>4</sup> + 2<sup>3</sup> + 2<sup>0</sup>_ which would mean that the
fifth, fourth and first row or column would be plotted as scatter plots. A value of -1 means all plots are scatter plots.

#### shapes (Array of Strings)
A list of shape names to be used in scatter plots. The names are taken sequentially from
the list and assigned to scatter plots. If there are too few shape names or they cannot be
looked up the a shape from an internal list is assigned.

Recognized names are:
1. circle
2. diamond
3. square
4. star

#### strokeWidth (Double _2.0_)
**Option:** `--stroke`<br/>
The width of the plotted paths

#### title (String)
**Option:** `--title`<br/>
The title attached to the SVG

#### width (Int _800_)
**Option:** `--width`<br/>
The width of the generated SVG.

#### xMax (Double _-inf_)
**Option:** `--xmax`<br/>
The maximum value for the abscissa.<sup>[2](#fn2)</sup>

#### xMin (Double _inf_)
**Option:** `--xmin`<br/>
The minimum value for the abscissa.<sup>[2](#fn2)</sup>

#### xTick (Int _0_)
How often to print the abscissa values and draw a line.<sup>[3](#fn3)</sup>

#### xTitle (String)
The title attached to the abscissa.

#### yMax (Double _-inf_)
**Option:** `--ymax`<br/>
The maximum value for the ordinate.<sup>[2](#fn2)</sup>

#### yMin (Double _inf_)
**Option:** `--ymin`<br/>
The minimum value for the ordinate.<sup>[2](#fn2)</sup>

#### yTick (Int _0_)
How often to print the ordinate values and draw a line.

#### yTitle (String)
the title attached to the ordinate

### Footnotes

<a id="fn1">1</a>: header columns or rows are used to name the pathe plotted.

<a id="fn2">2</a>: if not defined the min and max are taken from the data.

<a id="fn3">3</a>: setting this to -1 will remove the ticks.

<a id="fn4">4</a>: `--headers` will set both headerColumns and headerRows
