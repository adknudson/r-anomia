library(magrittr)
library(tinkr)
library(xml2)

rmd_file <- tinkr::yarn$new(path = "example-chunkname-options.Rmd")
code_blocks <- xml2::xml_find_all(
  x = rmd_file$body,
  xpath = ".//md:code_block",
  ns = rmd_file$ns
)

for (cb in code_blocks) {
  if (xml2::xml_attr(cb, "name") == "") {
    # generate name
    new_name <- paste0("myprefix-", stringi::stri_rand_strings(1, 6, "[a-f0-9]"))
    # set name
    xml2::xml_attr(cb, "name") <- new_name
    next
  }
  print(xml2::xml_attr(cb, "name"))
}

tmp <- tempfile(tmpdir = "../anomia", fileext = ".Rmd")
rmd_file$write(tmp)
