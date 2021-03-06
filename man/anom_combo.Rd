% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/anomia_classes.R
\name{anom_combo}
\alias{anom_combo}
\title{Create a combination name template}
\usage{
anom_combo(
  pattern,
  prefix = NULL,
  suffix = NULL,
  sep = "-",
  case = c("lower", "upper", "title", "sentence")
)
}
\arguments{
\item{pattern}{A list of word banks to use for names. See 'Details' for a
full list of word banks included in this package.}

\item{prefix}{A string to prepend to the names. Can be left NULL.}

\item{suffix}{A string to append to the names. Can be left NULL.}

\item{sep}{A string used for separating the prefix, words, and suffix.}

\item{case}{The capitalization used for the words. Can be "lower" (default), "upper",
"title", or "sentence". Does not affect the prefix or suffix.}
}
\description{
Create a combination name template
}
