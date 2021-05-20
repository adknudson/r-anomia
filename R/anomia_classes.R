# Combination Template ----------------------------------------------------------------

#' Constructor method for combination template
#'
#' @param pattern A list of word banks to use for names.
#' @param prefix A string to prepend to the names. Can be left NULL.
#' @param suffix A string to append to the names. Can be left NULL.
#' @param sep A string used for separating the prefix, words, and suffix.
#' @param case The capitalization used for the words. Can be "lower" (default), "upper",
#'     "title", or "sentence".
new_combo <- function(pattern = list(),
                      prefix = character(),
                      suffix = character(),
                      sep = character(),
                      case = character()) {
  structure(
    pattern,
    prefix = prefix,
    suffix = suffix,
    sep = sep,
    case = case,
    class = c("combo", "anomia_template", "list")
  )
}

#' Validator method for combination template
#'
#' @param x A combo template
validate_combo <- function(x) {
  pattern <- unclass(x)
  prefix <- attr(x, "prefix")
  suffix <- attr(x, "suffix")
  sep <- attr(x, "sep")
  case <- attr(x, "case")

  stopifnot(is.character(prefix) || is.null(prefix))
  stopifnot(is.character(suffix) || is.null(suffix))
  stopifnot(is.character(sep))
  stopifnot(is.character(case))

  stopifnot(length(prefix) <= 1)
  stopifnot(length(suffix) <= 1)
  stopifnot(length(sep)    <= 1)
  stopifnot(length(case)   <= 1)

  x
}

#' Create a combination name template
#'
#' @param pattern A list of character vectors.
#' @param prefix A string to prepend to the names. Can be left NULL.
#' @param suffix A string to append to the names. Can be left NULL.
#' @param sep A string used for separating the prefix, words, and suffix.
#' @param case The capitalization used for the words. Can be "lower" (default), "upper",
#'     "title", or "sentence". Does not affect the prefix or suffix.
#'
#' @export
anom_combo <- function(pattern,
                       prefix = NULL,
                       suffix = NULL,
                       sep = "-",
                       case = c("lower", "upper", "title", "sentence")) {
  if (missing(pattern)) pattern <- default_combo()
  if (is.null(sep)) sep <- ""
  case <- match.arg(case)

  validate_combo(new_combo(
    pattern,
    prefix,
    suffix,
    sep,
    case
  ))
}

#' @export
default_combo <- function() {
  list(
    c(adjectives, colors),
    c(animals, foods, fruits)
  )
}

#' @export
alternate_combo <- function() {
  list(verbs, adverbs)
}

# Random String Template --------------------------------------------------------------


# Sequential Template -----------------------------------------------------------------


# Regex Template ----------------------------------------------------------------------


# Generics ----------------------------------------------------------------------------

#' Generate words from a template
#' @param template An object of class "anomia_template".
#' @param n The number of names to generate.
#' @export
anom_generate_name <- function(template, n) {
  UseMethod("anom_generate_name")
}

#' @export
anom_generate_name.combo <- function(template, n = 1) {
  words <- lapply(X = template, FUN = sample, size = n, replace = TRUE)
  sep <- attr(template, "sep")
  words$sep <- sep
  words <- do.call(paste, words)

  case <- attr(template, "case")
  words <- switch (case,
          lower = stringr::str_to_lower(words),
          upper = stringr::str_to_upper(words),
          title = stringr::str_to_title(words),
          sentence = stringr::str_to_sentence(words)
  )

  prefix <- attr(template, "prefix")
  if (!(is.null(prefix) || prefix == "")) {
    words <- paste(prefix, words, sep = sep)
  }

  suffix <- attr(template, "suffix")
  if (!(is.null(suffix) || prefix == "")) {
    words <- paste(words, suffix, sep = sep)
  }

  words
}
