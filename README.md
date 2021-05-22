# CSV to Canvas/PDF/PNG/SVG converter

```
csv2 <canvas | pdf | png | svg> [<options>] [<csv-name> or -] [<json-name>] [out-name]
```

This program take the data in a CSV file and settings in a [JSON file](docs/json.md) to produce a Canvas(JS), PDF, PNG or SVG
file. If the CSV file name is missing or `-` the the data is read from the standard input. If the JSON file is not specified then `.json`
is appended to the CSV  file name. If the JSON file is missing then all defaults are used. If the output file is not specified then the
data is written to the  standard output except for PNG data.

The code handles most cases well but strange cases may fail. 
Numbers are expected to be in English format i.e. `.` is the decimal seperator.
JSON errors may cause a crash, probably without a helpful error message.<br/>
Most of the effort was put into generating the charts.

-  The [usage](docs/usage.md) is available.
-  As are some [examples](examples/examples.md).
-  Some of the options are mainly intended for [testing](docs/testing.md).
-  Specifying colours is covered [here](docs/colours.md).
-  SVG charts can be altered directly using [css](docs/css.md).

### Limitations

The biggest limitation is the handling of large values. These are clipped and hence the slopes of the plots may
be wrong. The values are clipped at the edges of a plane twice as wide and twice as high as the Canvas or SVG.
Plots that exceed the plottable area but not the limit above are drawn but can't be seen outside of that area, this
means that they have the correct shape.

Plot lines that are close to each other can be hard to tell apart e.g. sin(n) and sin²(n)
at or about 90° (π/2).
Using dashed lines helps but it can still be confusing.

The legends panel is limited in size and hence the plot names are restricted to 10
characters. The names are only taken from the first header row or column if they aren't
defined on the command line or in the JSON file.

The command line options take precedence.
There is no mixing of the colour values for example, they are all
taken from the JSON file or the command line.

There are no practical limits to the number of plots, one of my tests is to create an SVG from a CSV of 1000 rows of 1000 
columns of random integers. There were no problems generating it but I haven't tried to view the results, I don't think that it would 
be pleasant. The bitmaps used to select plots though are limited to 63 plots, the rest will still be plotted but can't be enhanced. 
The legends panel takes about 25 pixels with the default base font size, double that if lines or shapes are displayed, which means 
that with the default height of 600 pixels you can only count on 20 plots in the panel.

The [logo](docs/json.md#logoURL) is displayed using an `<image>` element which is loaded when the SVG is displayed.
At least some browsers don't load that image when the SVG is loaded in an HTML `<img>`. 
The same is true for Canvas charts but PNG charts have the logo loaded when it is created. PDF and PNG charts only support
bitmapped images but SVG charts can have SVG logos.

### Bugs
Way too many options!
