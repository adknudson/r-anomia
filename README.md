
<!-- README.md is generated from README.Rmd. Please edit that file -->

# anomia

<!-- badges: start -->
<!-- badges: end -->

The goal of `anomia` is to make it easy to give your R Markdown code
chunks a name. Broadly, *anomic aphasia* is the inability to retrieve a
word or the name of an object. Word selection anomia occurs when a
person knows how to use an object and can correctly select the target
object from a group of objects, and yet cannot name the object.

## Installation

`anomia` works by converting an R Markdown document to XML, modifying
the code blocks’ names, and then converting back to R Markdown. This
package relies on [tinkr](https://github.com/ropensci/tinkr) which is
not yet on CRAN.

To install `anomia`

``` r
remotes::install_github("ropenscilabs/tinkr")
remotes::install_github("adknudson/r-anomia")
```

## Examples

There are two primary ways to use this package. The first is to create a
naming template and then use it to name the unnamed chunks in a `.Rmd`
file. The second method is to give the naming spec in the YML header,
and then use the RStudio plugin to (re)name chunks.

### Using a Template

``` r
template <- anom_combo(
  pattern = list("colors",
                 c("animals", "fruits"),
                 "adverbs"),
  prefix = "001",
  suffix = NULL,
  sep = "-",
  case = "upper"
)

anom_name_chunks(path = "file.Rmd", template = template)
```

### Using a YML Spec

The same arguments used to create a naming template can be used in the
YML header file to specify a naming pattern. It will follow the
hierarchy of `anomia > type > arguments`

    ---
    title: "R Markdown Document"
    output:
      html_document: default
    anomia:
      combo:
        prefix: "001"
        pattern
          - colors
          - [animals, fruits]
          - adverbs
        sep: "-"
        case: "upper"
    ---

## Why?

Naming your chunks is a good idea, especially if you use the caching
feature while knitting. If no name is given, then `knitr` gives a
default name of `unnamed-chunk-XX`. This seems fine, until a new chunks
is inserted before others. This causes the names of chunks to be
updated, which invalidates the cache and hence code chunks will be
re-run to rebuild the cache. If a name is given, then rearranging chunks
does not invalidate the cache.

Why not just name the chunks yourself? Because we’re programmers and any
tedious task must be automated. Also not every chunk requires a
meaningful name, so having a program generate names for you is a
convenient way to not have to sweat the difficult task of coming up with
a name on your own.
