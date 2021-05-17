## code to prepare word lists from Enchanted Learning
library(magrittr)

get_el_wordlist <- function(word_list_name) {
  url <- glue::glue(
    "https://www.enchantedlearning.com/wordlist/",
    word_list_name,
    ".shtml"
  )
  try({
    html_file <- rvest::read_html(url)
    word_list <- html_file %>%
      rvest::html_element("div") %>%
      rvest::html_nodes(".wordlist-item") %>%
      rvest::html_text() %>%
      stringr::str_to_lower() %>%
      stringr::str_replace_all(" ", "-")
    return(word_list)
  })
}

adjectives <- get_el_wordlist("adjectives")
adverbs <- get_el_wordlist("adverbs")
animals <- get_el_wordlist("animal")
colors <- get_el_wordlist("colors")
foods <- get_el_wordlist("food")
fruits <- get_el_wordlist("fruit")
positive_words <- get_el_wordlist("positivewords")
regular_verbs <- get_el_wordlist("regularverbs")
shapes <- get_el_wordlist("shapes")

# need extra processing
# animals (remove parentheses)
# regular verbs (change to -ing)

usethis::use_data(adjectives, overwrite = TRUE)
usethis::use_data(adverbs, overwrite = TRUE)
usethis::use_data(animals, overwrite = TRUE)
usethis::use_data(colors, overwrite = TRUE)
usethis::use_data(foods, overwrite = TRUE)
usethis::use_data(fruits, overwrite = TRUE)
usethis::use_data(positive_words, overwrite = TRUE)
usethis::use_data(shapes, overwrite = TRUE)
