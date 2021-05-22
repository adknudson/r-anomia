write_datasets <- function() {
  f <- file("R/datasets.R", open = "w+")

  for (wb_file in list.files("data/")) {
    nm <- stringr::str_remove(wb_file, ".rda")
    Nm <- stringr::str_to_title(nm)
    load(paste0("data/", wb_file))
    assign("wb", get(nm))
    n <- length(wb)

    writeLines(text = glue::glue(
      "#' {Nm}\n",
      "#'\n",
      "#' A word bank of {n} {nm}\n",
      "#'\n",
      '"{nm}"\n\n'),
      con = f)
  }

  close(f)
}
