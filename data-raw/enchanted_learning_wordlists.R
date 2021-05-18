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

wb_adjectives <- get_el_wordlist("adjectives")
wb_adjectives <- wb_adjectives[str_detect(wb_adjectives, " |-", TRUE)]
wb_adjectives <- wb_adjectives[nchar(wb_adjectives) %in[]% c(4, 8)]

wb_adverbs <- get_el_wordlist("adverbs")
wb_adverbs <- wb_adverbs[str_detect(wb_adverbs, "ly$")]
wb_adverbs <- wb_adverbs[nchar(wb_adverbs) %in[]% c(4, 10)]

wb_animals <- get_el_wordlist("animal")
wb_animals <- wb_animals[str_detect(wb_animals, " |-", TRUE)]
wb_animals <- tolower(wb_animals)
wb_animals <- wb_animals[nchar(wb_animals) %in[]% c(4, 10)]

wb_colors <- get_el_wordlist("colors")
wb_colors <- wb_colors[str_detect(wb_colors, " ", TRUE)]
rm_wb_colors <- c(
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
wb_colors <- wb_colors[wb_colors %out% rm_wb_colors]

wb_foods <- get_el_wordlist("food")
wb_foods <- wb_foods[str_detect(wb_foods, " |-", TRUE)]
wb_foods <- tolower(wb_foods)
wb_foods <- wb_foods[nchar(wb_foods) %in[]% c(4, 8)]

wb_fruits <- get_el_wordlist("fruit")
wb_fruits <- wb_fruits[str_detect(wb_fruits, " |-", TRUE)]
wb_fruits <- wb_fruits[nchar(wb_fruits) %in[]% c(4, 10)]

wb_verbs <- rcorpora::corpora("words/verbs_with_conjugations")
wb_verbs <- unlist(wb_verbs$gerund)
wb_verbs <- wb_verbs[str_detect(wb_verbs, " |-", TRUE)]
wb_verbs <- wb_verbs[str_detect(wb_verbs, "ing$")]

usethis::use_data(
  wb_adjectives,
  wb_adverbs,
  wb_animals,
  wb_colors,
  wb_foods,
  wb_fruits,
  wb_verbs,
  overwrite = TRUE)
