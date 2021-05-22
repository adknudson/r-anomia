get_chunkname_opts <- function(rmd_path, encoding = "UTF-8") {
  rmd_yaml <- rmarkdown::yaml_front_matter(rmd_path, encoding = encoding)

  if ("anomia" %in% names(rmd_yaml)) {
    chunkname_opts <- rmd_yaml$anomia
    return(chunkname_opts)
  }

  NULL
}
