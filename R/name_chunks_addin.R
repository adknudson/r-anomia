anom_name_chunks_addin <- function() {
  anom_name_chunks(
    path = rstudioapi::selectFile(filter = "R Markdown Files (*.Rmd)")
  )
}
