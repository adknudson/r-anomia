#' @export
default_combo <- function() {
  list(
    c(wb_adjectives, wb_colors),
    c(wb_animals, wb_foods, wb_fruits)
  )
}

#' @export
alternate_combo <- function() {
  list(
    wb_verbs,
    wb_adverbs
  )
}

#' @export
generate_combo <- function(n = 1,
                           pattern = default_combo(),
                           prefix = NULL,
                           sep = "-",
                           case = c("lower", "upper", "title", "sentence")) {

  case <- match.arg(case)

  if (length(pattern) == 0)
    pattern <- default_combo()

  stopifnot(is.character(prefix) || is.null(prefix))
  stopifnot(is.character(sep))

  words <- lapply(pattern, sample, size = n, replace = TRUE)
  words$sep <- sep
  words <- do.call(paste, words)

  if (!is.null(prefix)) {
    words <- paste(prefix, words, sep = sep)
  }

  words <- switch (case,
    lower = stringr::str_to_lower(words),
    upper = stringr::str_to_upper(words),
    title = stringr::str_to_title(words),
    sentence = stringr::str_to_sentence(words)
  )

  words
}
