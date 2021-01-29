# UKUS-CROSSWALK.R
#
# This script generates a crosswalk between UK and US English words.
#
# Ben Davies
# January 2021

# Load packages
library(dplyr)
library(readr)
library(rvest)

# Read source HTML
source_html <- read_html("http://www.tysto.com/uk-us-spelling-list.html")

# Build crosswalk
ukus_crosswalk <- source_html %>%
  html_nodes("table") %>%
  {.[[2]]} %>%
  html_nodes(".Body td p") %>%
  as.character() %>%
  lapply(function(x) strsplit(sub("<p>(.*)</p>", "\\1", x), "<br>")[[1]]) %>%
  {tibble(uk = .[[1]], us = .[[2]])} %>%
  filter(!grepl("<", us)) %>%  # Remove "non-preferred" US words
  mutate_all(trimws)

# Export crosswalk
write_csv(ukus_crosswalk, "data-raw/ukus-crosswalk.csv")
if (!dir.exists("data")) dir.create("data/")
save(ukus_crosswalk, file = "data/ukus-crosswalk.rda", version = 2, compress = "bzip2")

# Save session info
bldr::save_session_info("data-raw/ukus-crosswalk.log")
