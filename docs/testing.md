#  Testing options

There are a number of options mainly intended for testing:

- `canvas tag`<br/>
This isn't so much an option but a command, it will generate an HTML canvas tag
based on the command line and JSON settings.

- `--colourslist` <sup>[1](#fn1)</sup><br/>
This option generates a chart with each of the colours included with the `--colours`
option followed by the internal colours list. Each colour is shown with a rectangle
and the colour's name or hex code in the colour named.<br/>
The `--bg` option can be used to set the background colour and the `--size` option to
set the text size.

- `--colournames`<br/>
Print the names and `#rrggbbaa` values of all the named colours known by this program.

- `--colournameslist` <sup>[1](#fn1)</sup><br/>
Similar to `--colourslist` except that all the named colours are included, [e,g.](examples/colourNamesList.png).

- `--dashlist` <sup>[1](#fn1)</sup><br/>
Similar to `--colourlist` but for dashes.

- `--random`<br/>
This option generates random CSV data that is then displayed as normal. There are four
possible values attached to the option. The first is the number of rows and columns e.g.
`--random 100` generates a matrix of 100 rows and 100 columns. The optional second
parameter is the maximum value, if not supplied the a reasonable value is chosen.
The optional third parameter is the minimum value, if not supplied it is the minus of the
maximum value.
More than 15 plots aren't really a good idea unless you have a big chart.

- `--shapenames`<br/>
This option lists the names of all the shapes as plain text.

- `--show` <sup>[1](#fn1)</sup><br/>
Generate an image with just the named shape. The width and height are six times the stroke-width (`--stroke`).

### Footnotes

- <a id="fn1">1</a>: Any JSON or CSV file specified on the command line are ignored, all settings are taken from
the command line. If the output file is to be specified then it still need to be the third file name on the command line,
the other two are ignored.
