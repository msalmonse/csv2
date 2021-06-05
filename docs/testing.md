#  Testing options

There are a number of options mainly intended for testing:

- `-tag <file>`<br/>
This optiont will generate an HTML canvas tag based on the command line and JSON settings and write it to 
the `file` specified.

- `show colours` <sup>[1](#fn1)</sup><br/>
This sub command generates a chart with each of the colours included with the `--colours`
option followed by the internal colours list. Each colour is shown with a rectangle
and the colour's name or hex code in the colour named.<br/>
The `--bg` option can be used to set the background colour and the `--size` option to
set the text size.

- `list colournames`<br/>
Print the names and `#rrggbbaa` values of all the named colours known by this program.

- `show colournames` <sup>[1](#fn1)</sup><br/>
Similar to `show colours` except that all the named colours are included, [e,g.](examples/colourNamesList.png).

- `show dashes` <sup>[1](#fn1)</sup><br/>
Similar to `show colours` but for dashes.

- `--random`<br/>
This option generates random CSV data that is then displayed as normal. There are four
possible values attached to the option. The first is the number of rows and columns e.g.
`--random 100` generates a matrix of 100 rows and 100 columns. The optional second
parameter is the maximum value, if not supplied the a reasonable value is chosen.
The optional third parameter is the minimum value, if not supplied it is the minus of the
maximum value.
More than 15 plots aren't really a good idea unless you have a big chart.

- `list shapes`<br/>
This sub command lists the names of all the shapes as plain text.

- `show <shape>` <sup>[1](#fn1)</sup><br/>
Generate an image with just the named shape. The width and height are six times the stroke-width (`--stroke`).

- `list json`<br/>
This sub command is similar to `help usage` but the data is presented in JSON format.

### Footnotes

- <a id="fn1">1</a>: Any JSON or CSV file specified on the command line are ignored, all settings are taken from
the command line. If the output file is to be specified then it still need to be the third file name on the command line,
the other two are ignored.
