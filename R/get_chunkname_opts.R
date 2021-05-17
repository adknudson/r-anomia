get_chunkname_opts <- function(rmd_path, encoding = "UTF-8") {
  rmd_yaml <- rmarkdown::yaml_front_matter(rmd_path, encoding = encoding)

  if ("chunknames" %in% names(rmd_yaml)) {
    chunkname_opts <- rmd_yaml$chunknames
    # chunkname_opts <- validate_chunkname_opts(chunkname_opts)
    return(chunkname_opts)
  }

  chunkname_opts <- default_chunkname_opts()

  return(chunkname_opts)
}
