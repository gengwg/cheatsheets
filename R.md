# R

## Installation

### Install on Debian

Get a list of R packages available in Debian:

```
# apt-cache search '^r-'
```

Install most of them, pruning out a few unused groups:

```
apt-cache search '^r-' \
    | egrep -v -i '(biology|genetic|map)' \
    | egrep -v -i sql \
    | awk '/^r\-/ {print $1}' \
    | xargs apt-get install --yes
```

Then start R:

```
$ R

R : Copyright 2003, The R Foundation for Statistical Computing
Version 1.8.1  (2003-11-21), ISBN 3-900051-00-3
...
Type 'q()' to quit R.
>
```

### Installing CRAN packages

Many CRAN packages aren't in Debian. Become root, start `R`, and use
`install.packages`:

```
$ su
# R
> install.packages("fracdiff")
```

Caveats vs Debian packages:

- No dependency resolution.
- The package database file is re-downloaded every time.
- No `dist-upgrade`.

Prefer Debian packages where possible.

### Installing from `.tar.gz`

```
# R CMD INSTALL file1.tar.gz file2.tar.gz ...
```

## Usage examples

### Matrix and apply

```
# create a matrix of 10 rows x 2 columns
m <- matrix(c(1:10, 11:20), nrow = 10, ncol = 2)

# mean of the rows
apply(m, 1, mean)
# [1]  6  7  8  9 10 11 12 13 14 15

# mean of the columns
apply(m, 2, mean)
# [1]  5.5 15.5
```

### Permutation

```
> sample(1:10)
 [1]  1  4  8  5  9  2  7  3  6 10
```

### Plot to a PDF file

```
pdf(file = "testRplot.pdf")
x <- rnorm(100)
hist(x)
dev.off()
```
