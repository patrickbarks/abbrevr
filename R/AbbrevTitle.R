#' Abbreviate a journal title using the ISO 4 standard
#'
#' Abbreviate a journal title using the ISO 4 standard. \cr\cr A pdf outline of
#' the ISO 4 rules for abbreviation can be found at
#' \url{http://www.uai.cl/images/sitio/biblioteca/citas/ISO_4_1997en.pdf}, and a
#' text file containing the ISSN List of Title Word Abbreviations can be found
#' at \url{http://www.issn.org/services/online-services/access-to-the-ltwa}.
#'
#' @param x A journal title in the form of a string.
#' @return A string reflecting the abbreviated form of \code{x}, based on the
#'   ISO 4 standard.
#' @author Patrick Barks <patrick.barks@@gmail.com>
#' @examples
#' AbbrevTitle("Journal of Great Lakes Research")
#' AbbrevTitle("Transactions of the American Fisheries Society")
#' AbbrevTitle("Journal of Chemical & Engineering Data")
#' AbbrevTitle("AT&T Technical Journal")
#' AbbrevTitle("Annalen der Physik")
#' AbbrevTitle("Deutsche Medizinische Wochenschrift")
#' AbbrevTitle("Les Annales du Théâtre et de la Musique")
#' AbbrevTitle("Revue d'Égyptologie")
#' AbbrevTitle("L'Intermédiaire des Mathématiciens")
#' @export AbbrevTitle
AbbrevTitle <- function(x) {
  # TODO: retain terms in parentheses
  # TODO: retain punctuation, except commas (convert periods to commas)
  # TODO: remove articles from other languages?

  # check for invalid x
  if(length(x) > 1) {
    stop('Please provide a single string (length(x) should equal 1)')
  }

  # remove parentheses and punctuation, and split string into vector of
  #  individual words/terms
  x <- gsub('[[:space:]]\\(.+\\)|\\,|\\.', '', x)
  xv <- unlist(strsplit(x, ' '))

  # if title contains only one word, return that word
  if (length(xv) == 1) {
    out <- ToTitleCase(xv)
  } else {
  # otherwise... check for matching multi-word phrases

    # vector to track which elements of xv already abbreviated
    xv_which_abb <- logical(length(xv))

    # search for multi-word matches (e.g. South Pacific)
    lgl_phrase <- sapply(ltwa_phrase$WORD, function(y) grepl(y, tolower(x)), USE.NAMES = FALSE)
    ind_phrase <- which(lgl_phrase)

    # if any matching multi-word phrases
    if (length(ind_phrase) > 0) {
      for (i in 1:length(ind_phrase)) {
        match_phrase <- unlist(strsplit(ltwa_phrase$WORD[ind_phrase[i]], '[[:space:]]'))
        match_abb <- ltwa_phrase$ABBREVIATIONS[ind_phrase[i]]
        ind_match <- sapply(match_phrase, function(y) grep(y, tolower(xv)), USE.NAMES = FALSE) # should only find sequential matches
        xv[ind_match[1]] <- match_abb
        xv_which_abb[ind_match[1]] <- TRUE
        xv <- xv[-ind_match[-1]]
        xv_which_abb <- xv_which_abb[-ind_match[-1]]
      }
    }

    # if title fully matches multi-word phrase(s), return
    if (all(xv_which_abb == TRUE)) {
      out <- xv
    } else {
      # otherwise... deal with prepositions, articles, and conjunctions

      # remove prepositions not at beginning of word
      CheckPrep <- function(x, check) {
        if(check == TRUE) {
          return(ifelse(tolower(x) %in% df_prep$word, TRUE, FALSE))
        } else {
          return(FALSE)
        }
      }

      ind_rem_prep <- c(FALSE, mapply(CheckPrep, USE.NAMES = F, x = xv[-1], check = !xv_which_abb[-1]))
      xv <- xv[!ind_rem_prep]
      xv_which_abb <- xv_which_abb[!ind_rem_prep]

      # remove articles and conjunctions
      CheckArtCon <- function(x, check) {
        if(check == TRUE) {
          return(ifelse(tolower(x) %in% df_artcon$word, TRUE, FALSE))
        } else {
          return(FALSE)
        }
      }

      ind_rem_artcon <- mapply(CheckArtCon, USE.NAMES = F, x = xv, check = !xv_which_abb)
      xv <- xv[!ind_rem_artcon]
      xv_which_abb <- xv_which_abb[!ind_rem_artcon]

      # remove d' and l', if followed by character
      xv <- gsub("^d'(?=[[:alpha:]])|^l'(?=[[:alpha:]])", "", xv, ignore.case = TRUE, perl = TRUE)

      # if title fully matches multi-word phrase(s) (minus articles/conjunctions), return
      if (all(xv_which_abb == TRUE)) {
        out <- xv
      } else {
        # otherwise... check for hyphenated words

        # TODO: don't check already-abbreviated terms for hyphens
        # check for hyphenated words
        ind_dash <- grep('[[:alpha:]]-[[:alpha:]]', xv)
        if (length(ind_dash) > 0) {
          # if hyphens, split hyphenated strings into vectors
          xv <- unlist(strsplit(xv, '-'))

          # update xv_which_abb based on hyphens
          for(i in length(ind_dash):1) {
            xv_which_abb <- append(xv_which_abb, FALSE, ind_dash[i])
          }
        }

        # abbreviate all words in title (excluding multi-word phrases)
        abbrev_full <- mapply(AbbrevTerm, x = xv, check = !xv_which_abb, USE.NAMES = F)

        # add dashes back in, if applicable
        if (length(ind_dash) > 0) {
          for(i in 1:length(ind_dash)) {
            dashed_terms <- abbrev_full[c(ind_dash[i], ind_dash[i] + 1)]
            abbrev_full[ind_dash[i]] <- paste(dashed_terms, collapse = '-')
            abbrev_full <- abbrev_full[-(ind_dash[i] + 1)]
          }
        }

        # collapse title to vector
        out <- paste(abbrev_full, collapse = ' ')
      }
    }
  }
  return(out)
}
