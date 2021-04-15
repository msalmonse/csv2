# CVS Parser

### State machine

| Current State | Condition | Next State |
| --- | --- | --- |
| | Initial state | lineStart |
| lineStart | ws<sup>[1](#fn1)</sup> | lineStart |
|  | `"` | quoted |
|  | `,`<sup>[2](#fn2)</sup> | fieldStart |
|  | nl<sup>[3](#fn3)</sup> | lineStart |
|  | else | normal |

### Footnotes

- <a id="fn1">1</a> `ws` is an abreviation for whitespace, it has many meanings but here
it means carriage return, new line or, space.
- <a id="fn2">2</a> The parser can handle other field separators than comma but it is the default
- <a id="fn3">3</a> nl is an abreviation for new line
