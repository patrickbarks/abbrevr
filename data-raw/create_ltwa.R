
# load required libraries
library(dplyr)

# read ltwa data
ltwa <- read.delim('data-raw/LTWA_20160915.txt',
                   na.strings = 'n.a.',
                   fileEncoding = 'UTF-16LE',
                   stringsAsFactors = FALSE) %>%
  mutate(WORD = tolower(WORD))

# subset prefix terms ending in dash (e.g. 'ecol-')
ltwa_prefix <- ltwa %>%
  slice(grep('-$', WORD)) %>%
  slice(grep('^-', WORD, invert = TRUE)) %>%
  mutate(WORD = gsub('-', '', WORD))

# subset multi-word phrases
ltwa_phrase <- ltwa %>%
  slice(grep('[[:alpha:]] [[:alpha:]]', WORD))

# subset single words, non-prefix
ltwa_singles <- ltwa %>%
  slice(grep('-$', WORD, invert = TRUE)) %>%
  slice(grep('^-', WORD, invert = TRUE)) %>%
  slice(grep('[[:alpha:]] [[:alpha:]]', WORD, invert = TRUE))


# common articles/conjunctions and prepositions in a few languages
arti_eng <- c("a", "an", "the")
prep_eng <- c("for", "on", "of", "in", "with", "to", "by", "at")
conj_eng <- c("and", "&", "or", "as")

arti_fre <- c("en", "et", "la", "le", "les")                       # D' treated separately
prep_fre <- c("à", "au", "aux", "avec", "dans", "de", "du", "des") # L' treated separately
conj_fre <- c("ou", "et")

arti_ger <- c("die", "das", "der", "ein", "eine")
prep_ger <- c("für")
conj_ger <- c("und")

df_arti <- data.frame(word = c(arti_eng, arti_fre, arti_ger),
                      lang = c(rep('eng', length(arti_eng)),
                               rep('fre', length(arti_fre)),
                               rep('ger', length(arti_ger))),
                      stringsAsFactors = F) %>%
  mutate(type = 'arti')

df_prep <- data.frame(word = c(prep_eng, prep_fre, prep_ger),
                      lang = c(rep('eng', length(prep_eng)),
                               rep('fre', length(prep_fre)),
                               rep('ger', length(prep_ger))),
                      stringsAsFactors = F)

df_conj <- data.frame(word = c(conj_eng, conj_fre, conj_ger),
                      lang = c(rep('eng', length(conj_eng)),
                               rep('fre', length(conj_fre)),
                               rep('ger', length(conj_ger))),
                      stringsAsFactors = F) %>%
  mutate(type = 'conj')

df_artcon <- rbind.data.frame(df_arti, df_conj)


# save
devtools::use_data(ltwa_singles, ltwa_prefix, ltwa_phrase, df_prep, df_artcon,
                   internal = TRUE, overwrite = T)

