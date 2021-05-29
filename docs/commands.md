## commands

#### Main commands

The first argument on the command line is the main command. It
can optionally be followed by a show sub-command but normally
isn't, see below for details.

```
    canvas               Generate javascript to draw the chart on
                         a HTML5 canvas.
    pdf                  Generate a PDF chart.
    png                  Generate a PNG chart.
    svg                  Generate an SVG chart.
```

#### Sub-commands

There are a number of sub-commands that follow the main chart
commands the generate charts using internal information rather
than from CSV data. They are intended to help with deciding
amongst formatting options.

```
    show colournames     Create a chart of all of the colours
                         known to this program.
    show colours         Create a chart of the colours that are
                         user defined as well as those internally
                         defined.
    show dashes          Create a chart of the dashes that are
                         user defined as well as those internally
                         defined.
```

#### List commands

As well as the chart main commands there are a few commands
that provide information without generating a chart. These
commands print internal information to help with settings.

```
    bitmap               Take a list of rows or columns and print
                         the corresponding bitmap
    list colournames     List the colour names known to the
                         program
    list json            Like 'help usage' but with the output in
                         JSON
    list shapes          List the shape names defined internally
    version              List the version
```
