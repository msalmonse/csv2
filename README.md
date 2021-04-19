# CSV to SVG converter

```
csv2 <canvas | png | svg> [<options>] [<csv-name> or -] [<json-name>] [svg-name]
```

This program take the data in a CSV file and settings in a [JSON file](json.md) to produce an SVG file. If the CSV file name is
missing or `-` the the data is read from the standard input. If the JSON file is not specified then `.json` is appended to the CSV 
file name. If the JSON file is missing then all defaults are used. If the svg file is not specified then the svg data is written to the 
standard output.

The code handles most cases well but strange cases may fail. 
Numbers are expected to be in English format i.e. `.` is the decimal seperator.
JSON errors may cause a crash, probably without a helpful error message.<br/>
Most of the effort was put into generating the Canvas and SVG.

The [usage](usage.md) is available as are some [examples](examples/examples.md).<br/>
Some of the options are mainly intended for [testing](Testing.md).

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

The command line options take precedence if they differ from the defaults. There is no way to reset a value defined in the JSON
file back to the default.
There is no mixing of the colour values for example, they are all
taken from the JSON file or the defaults which in turn can be set from the command line.

There are no practical limits to the number of plots, one of my tests is to create an SVG from a CSV of 1000 rows of 1000 
columns of random integers. There were no problems generating it but I haven't tried to view the results, I don't think that it would 
be pleaseant. The bitmaps used to select plots though are limited to 63 plots, the rest will still be plotted but can't be enhanced. 
The legends panel takes about 25 pixels with the default base font size, double that if lines or shapes are displayed, which means 
that with the default height of 600 pixels you can only count on 20 plots in the panel.

The [logo](json.md#logoURL) is displayed using an `<image>` element which is loaded when the SVG is displayed. At least some browsers don't load that image when the SVG is loaded in an HTML `<img>`. Using an `<svg>` does work though.

This command uses the
[Swift Argument Parser](https://github.com/apple/swift-argument-parser), which is, IMHO,
excellent but has some limitations itself, in particular I noticed that `-d1` wasn't
allowed, use `-d 1` instead. It also doesn't like negative numbers and can interpret them as options, whenever possible use
`-d=-1` instead.

### Bugs
Way too many options!
