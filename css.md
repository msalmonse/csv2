#  CSS usage

All styling is done using CSS which can be modified although that may mean that the SVG
looks strange. As an example I modified the stroke width of a plot but inadvertently
changed the stroke width of the related text.

Each plot has a class, either set using the [`cssClasses`](json.md#cssClasses) tag or assigned as `plot01`, `plot02` etc.. That class is used by both a path and a text element,
the path is the plot itself and the text is the name in the legends panel. Those classes
can be changed using [`cssExtras`](json.md#cssExtras) or
[`cssInclude`](json.md#cssInclude) tags and either of them can include an `@include`.<br/>
**N.B.** the paths and texts are styled separately which means that they need to be
updated separately other wise the precedence rules of CSS will take the longer selector,
e.g.<br/>
`.plot02 { stroke: black }` will not change anything, it needs to be
`path.plot02, text.plot02 { stroke: black }`.<br/>
Also the `fill` for paths is none while for texts it is the same as `stroke` so just
changing the `stroke` for both may give som surprising results.

### The Paths

**path** `{ stroke-width: 2.0; fill: none; stroke-linecap: round }` sets the default
styling for all paths. The `stroke-width` is the value set using the [`strokeWidth`](json.md#strokeWidth) tag.
