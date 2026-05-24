Flow content (i.e. everything that starts with { or [) can span multiple lines, but must be indented at least as many spaces as the surrounding current block level.

Block list items can (but don't need to) have the same indentation as the surrounding block level because - is considered part of the indentation:

```
a:    # top-level key
- b   # value of that key, which is a list
- c
c:    # next top-level key
 d    # non-list value which must be more indented
```
