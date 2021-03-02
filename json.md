# Settings

The settings file is JSON encoded and the following tags are supported:

#### colours (Array of Strings)
The colours to be used to plot the column or row. The index, if present, must be included although never used.
Columns or rows that aren't defined are assigned a colour sequentially from an internal list.

#### headerColumns (Int 0)
The number of columns that do not contain data.<sup>[1]("#fn1")</sup>

#### headerRows (Int 0)
The number of rows that do not contain data.<sup>[1]("#fn1")</sup>

#### height (Int 500)
The height of the generated SVG

#### inColumn (Bool true)
Plot the data in columns, currently forced to true.

#### index (Int 0)
The column or row that contains the absissa data with the leftmost column or top row being 1.<br/>
If it is less than or equal to zero then the absica is 0 for the first vale of each plot and so on.

#### names (Array of Strings)
The plotted column or rows are assigned names from this array or the first header row or column respectively.
The name are included with the colours associated with the plots.

#### title (String)
The title attached to the SVG

#### width (Int 500)
The width of the generated SVG.

#### xMax (Double)
The maximum value for the abscissa.<sup>[2]("#fn2")</sup>

#### xMin (Double)
The minimum value for the abscissa.<sup>[2]("#fn2")</sup>

#### xTick (Int 0)
How often to print the abscissa values and draw a line.

#### xTitle (String)
The title attached to the abscissa.

#### yMax (Double)
The maximum value for the ordinate. [^2]

#### yMin (Double)
The minimum value for the ordinate. [^2]

#### yTick (Int 0)
How often to print the ordinate values and draw a line.
#### yTitle (String)
the title attached to the ordinate

### Footnotes

<a id="fn1">1</a>: header columns or rows are used to name the pathe plotted.

<a id="fn2">2</a>: if not defined the min and max are taken from the data.
