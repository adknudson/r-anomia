## code to prepare word lists from Enchanted Learning
library(magrittr)
library(stringr)
library(inops)

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
      rvest::html_text()
    return(word_list)
  })
}

adjectives <- get_el_wordlist("adjectives")
adjectives <- adjectives[str_detect(adjectives, " |-", TRUE)]
adjectives <- adjectives[nchar(adjectives) %in[]% c(4, 8)]

adverbs <- get_el_wordlist("adverbs")
adverbs <- adverbs[str_detect(adverbs, "ly$")]
adverbs <- adverbs[nchar(adverbs) %in[]% c(4, 10)]

animals <- get_el_wordlist("animal")
animals <- animals[str_detect(animals, " |-", TRUE)]
animals <- tolower(animals)
animals <- animals[nchar(animals) %in[]% c(4, 10)]

colors <- get_el_wordlist("colors")
colors <- colors[str_detect(colors, " ", TRUE)]
rm_colors <- c(
  "apricot",
  "buff",
  "cardinal",
  "color",
  "complementary",
  "hue",
  "lemon",
  "lime",
  "peach",
  "primary",
  "pumpkin",
  "salmon",
  "secondary",
  "sahde",
  "spectrum",
  "tangerine",
  "tint",
  "tomato",
  "wheat"
)
colors <- colors[colors %out% rm_colors]

foods <- get_el_wordlist("food")
foods <- foods[str_detect(foods, " |-", TRUE)]
foods <- tolower(foods)
foods <- foods[nchar(foods) %in[]% c(4, 8)]

fruits <- get_el_wordlist("fruit")
fruits <- fruits[str_detect(fruits, " |-", TRUE)]
fruits <- fruits[nchar(fruits) %in[]% c(4, 10)]

verbs <- rcorpora::corpora("words/verbs_with_conjugations")
verbs <- unlist(verbs$gerund)
verbs <- verbs[str_detect(verbs, " |-", TRUE)]
verbs <- verbs[str_detect(verbs, "ing$")]

usethis::use_data(
  adjectives,
  adverbs,
  animals,
  colors,
  foods,
  fruits,
  verbs,
  overwrite = TRUE)
