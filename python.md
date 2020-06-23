* Print ASCII non-printable characters

```
>>> print(b'hi\n'.decode('ascii'))
hi
```

* Split text after the second occurrence of character

```
>>> a = "some-sample-filename-to-split"
>>> "-".join(a.split("-", 2)[:2])
'some-sample'
```
