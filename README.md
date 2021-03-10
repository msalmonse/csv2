# CSV to SVG converter

```
csv2svg [<options>] [<csv-name>] [<json-name>]
```

This program take the data in a CSV file and settings in a [JSON file](json.md) to produce an SVG file. If the JSON file
is not specified then `.json` is appended to the CSV file name. If the JSON file is missing then all defaults are used.

The code handles vanilla cases well but other cases may fail. In particular quoted text isn't properly handled,
the quotes are just ignored. Numbers are expected to be in English format i.e. `.` is the decimal seperator.
JSON errors may cause a crash, probably without an error message.<br/>
Most of the effort was put into generating the SVG.

The [usage](usage.md) is available.
