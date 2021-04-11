#  Testing options

There are a number of options mainly intended for testing:

- `--canvastag` <sup>[1](#fn1)</sup><br/>
Generate an HTML canvas tag.

- `--colourslist` <sup>[1](#fn1)</sup><br/>
This option generates an SVG with each of the colours included with the `--colours`
option followed by the internal colours list. Each colour is shown with a rectangle
and the colour's name or hex code in the colour named.<br/>
The `--bg` option can be used to set the background colour and the `--size` option to
set the text size.

- `--dashlist` <sup>[1](#fn1)</sup><br/>
Similar to `--colourlist` but for dashes.

- `--random`<br/>
This option generates random CSV data that is then displayed as normal. There are four
possible values attached to the option. The first is the number of rows and columns e.g.
`--random 100` generates a matrix of 100 rows and 100 columns. The optional second
parameter is the maximum value, if not supplied the a reasonable value is chosen.
The optional third parameter is the minimum value, if not supplied it is the minus of the
maximum value. The final value is an negative offset to the minimum and maximum
values as the argument parser has a problem with negative numbers.<br/>
Due to a limitation in Swift Argument Parser these numbers can't be negative.<br/>
The optional fourth argument is subtracted from the other two so that negative values can be used.<br/>
More than 15 plots aren't really a good idea unless you have a big SVG.<br/>
The data is random but follows a patterm that is more obvious in when displayed in columns.

- `--shapenames`<br/>
This option lists the names of all the shapes as plain text.

- `--show` <sup>[1](#fn1)</sup><br/>
Generate an SVG with just the named shape. The width and height are six times the stroke-width (`--stroke`).

### Footnotes

- <a id="fn1">1</a>: Any JSON or CSV file specified on the command line are ignored, all settings are taken from
the command line. If the output file is to be specified then it still need to be the third file name on the command line,
the other two are ignored.
