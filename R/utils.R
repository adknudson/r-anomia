#' Get the anomia spec from a yml header
anom_get_yml <- function(path, encoding = "UTF-8") {
  yml <- rmarkdown::yaml_front_matter(path, encoding = encoding)
  yml$anomia # expected to return NULL if 'anomia' is not in list
}

#' Takes in the anomia yml spec and returns a name template
anom_parse_yml <- function(yml) {
  if (is.null(yml))
    return(anom_combo())

  # use only the first accepted anomia template type
  yml <- yml[names(yml) %in% c("combo", "random", "regex", "regex2")]
  if (length(yml) == 0)
    return(anom_combo())

  template <- yml[[1]]
  template_type <- names(yml)[1]

  switch (template_type,
    combo  = anom_parse_yml_combo(template),
    random = anom_parse_yml_random(template),
    regex  = anom_parse_yml_regex(template),
    regex2 = anom_parse_yml_regex2(template),
    anom_combo() # default fallback
  )
}

anom_parse_yml_combo <- function(yml) {
  pattern <- yml$pattern
  if (is.null(pattern))
    pattern <- anom_combo_default()

  pattern <- lapply(pattern, function(wb) {
    # word banks are given by name, so they need to be retrieved
    do.call(c, lapply(wb, get, pos = 1))
  })

  prefix  <- yml$prefix
  suffix  <- yml$suffix

  sep <- yml$sep
  if (is.null(sep))
    sep <- "-"

  case <- yml$case
  if (is.null(case))
    case <- "lower"

  anom_combo(
    pattern = pattern,
    prefix  = prefix,
    suffix  = suffix,
    sep     = sep,
    case    = case
  )
}

anom_write_datasets <- function() {
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
