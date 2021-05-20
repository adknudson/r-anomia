#' Give a name to unnamed code blocks in an R Markdown document
#'
#' @param path The path to an R Markdown file
#' @param template An anomia name template class
#' @param overwrite Should the modified R Markdown file be overwritten.
#' @param unname_chunks Should existing chunk names be removed before generating new names.
#'     This will try to preserve the "setup" block.
#'
#' @export
name_chunks <- function(path, template, unname_chunks = FALSE, overwrite) {
  rmd_file <- tinkr::yarn$new(path)

  # code_blocks is linked to the rmd_file, so it is possible to modify elements of this and
  # then write with the rmd_file.
  code_blocks <- xml2::xml_find_all(
    x = rmd_file$body,
    xpath = ".//md:code_block",
    ns = rmd_file$ns
  )

  # get a character vector of all the chunk names
  cb_names <- vapply(X = code_blocks,
                     FUN = xml2::xml_attr,
                     FUN.VALUE = character(1),
                     attr = "name")

  if (unname_chunks) {
    is_setup_block <- grepl("setup", cb_names) # try to preserve setup block
    cb_names[!is_setup_block] <- ""
  }

  has_no_name <- cb_names == ""
  num_unnamed <- sum(has_no_name)

  if (missing(template))
    template <- anom_combo()

  cb_names[has_no_name] <- anom_generate_name(template, num_unnamed)
  xml2::`xml_attr<-`(code_blocks, "name", value = cb_names)

  if (missing(overwrite))
    overwrite <- getOption("anomia_overwrite_file", default = TRUE)

  if (!overwrite) {
    tmp <- tempfile(tmpdir = dirname(path), pattern = "file_", fileext = ".Rmd")
    rmd_file$write(tmp)
  } else {
    rmd_file$write(path)
  }

  NULL
}
