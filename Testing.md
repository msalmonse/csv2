#  Test options

There are a number of options mainly intended for testing:

- `--colourslist`:<br/>
This option generates an SVG with each of the colours included with the `--colours`
option followed by the internal colours list. Each colour is shown with a rectangle
and the colour's name or hex code in the colour named.<br/>
The `--bg` option can be used to set the background colour and the `--size` option to
set the text size.

- `--dashlist`<br/>
Similar to `--colourlist` but for dashes.

- `--random`<br/>
This option generates random CSV data that is then displayed as normal. There are three
possible values attached to the option. The first is the number of rows and columns e.g.
`--random 100` generates a matrix of 100 rows and 100 columns. The optional second
parameter is the maximum value, if not supplied the a reasonable value is chosen.
The optional third parameter is the minimum value, if not supplied it is the minus of the
maximum value.<br/>
Due to a limitation in Swift Argument Parser these numbers can't be negative.<br/>
More than 15 plots aren't really a good idea unless you have a big SVG.<br/>
The data is random but follows a patterm that is more obvious in when displayed in columns.

- `--shapenames`<br/>
This option lists the names of all the shapes as plain text.

- `--show`<br/>
Generate an SVG with just the named shape. The width and height are six times the stroke-width (`--stroke`).
