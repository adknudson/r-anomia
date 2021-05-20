add_prefix <- function(words, prefix, sep) {
  if (!(is.null(prefix) || prefix == "")) {
    words <- paste(prefix, words, sep = sep)
  }
  words
}
