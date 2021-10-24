#' Abbreviate a word within a journal title based on the ISSN's List of Title
#' Word Abbreviations
#'
#' Abbreviate a word within a journal title based on the ISSN's List of Title
#' Word Abbreviations (LTWA). \cr\cr NOTE: this function only abbreviates single
#' terms, not full titles. It is a helper function called by \code{AbbrevTitle}.
#'
#' @param x A single word from a journal title, in the form of a string.
#' @param check A logical indicating whether to check for an abbreviation (if
#'   TRUE), or always return the original word (if FALSE). This is a convenience
#'   argument that simplifies vectorization within the function
#'   \code{AbbrevTitle}.
#' @return A string reflecting the abbreviated form of \code{x}, or, if
#'   \code{check == FALSE} or no abbreviation is found, the original \code{x}.
#' @author Patrick Barks <patrick.barks@@gmail.com>
#' @examples
#' AbbrevTerm("Canadian")
#' AbbrevTerm("journal")
#' AbbrevTerm("Entomology")
#' AbbrevTerm("medical")
#' AbbrevTerm("PLoS")
#' AbbrevTerm("Acuático")
#' AbbrevTerm("Investigación")
#' AbbrevTerm("Investigación", check = FALSE)
#'
#' \dontrun{
#' # argument should be a single word (i.e. a string with no spaces)
#' # use function AbbrevTitle() to abbreviate a full title
#' AbbrevTerm("Canadian Journal of Entomology")
#' }
#' @seealso AbbrevTitle
#' @import stringi
#' @export AbbrevTerm
AbbrevTerm <- function(x, check = TRUE) {

  if (check == FALSE) {
    out <- x
  } else {
    # check for invalid x
    if(length(x) > 1) {
      stop('Please provide a single string (length(x) should equal 1)')
    } else if (grepl('[[:space:]]', x)) {
      warning('The provided string contains spaces. This function is only designed to abbreviate a single word.')
    }

    # check whether x is title case
    ch1 <- substr(x, 1, 1)
    is_title <- ch1 == toupper(ch1)

    # check for whole word match
    # TODO: find way to deal with multiple whole word matches (e.g. w/ and w/o diacritics)
    int_whole_match <- stringi::stri_cmp_equiv(x, ltwa_singles$WORD, strength = 1)
    ind_whole_match <- which(int_whole_match == TRUE)

    if (length(ind_whole_match > 0)) {
      # if whole-word match is found, return corresponding abbrev (if no abbrev,
      #  return original x)
      abbrev <- ltwa_singles$ABBREVIATIONS[ind_whole_match]
      word <- ltwa_singles$WORD[ind_whole_match]
      out <- ifelse(is.na(abbrev), word, abbrev)
    } else {
      # else, find matching prefix
      # TODO: give preference to matches with higher strength
      lgl_prefix <- stringi::stri_startswith_coll(x, ltwa_prefix$WORD, strength = 1)
      ind_prefix <- which(lgl_prefix == TRUE)

      # choose abbrev based on number of matching prefixes (0, 1, or 2+)
      if (length(ind_prefix) == 0) {
        # if no matching prefixes, return original x
        out <- x
      } else if (length(ind_prefix) == 1) {
        # if one matching prefixes, return corresponding abbrev
        out <- ltwa_prefix$ABBREVIATIONS[ind_prefix]
        if (is.na(out)) out <- x
      } else {
        # if multiple matching prefixes, choose abbrev from longest match
        ind_prefix <- ind_prefix[which.max(nchar(ltwa_prefix$WORD[ind_prefix]))]
        out <- ltwa_prefix$ABBREVIATIONS[ind_prefix]
      }
    }

    # if x contains only latin chars, remove any diacritics from abbrev
    if (stringi::stri_trans_general(x, 'Latin-ASCII') == x) {
      out <- stringi::stri_trans_general(out, 'Latin-ASCII')
    }

    # if x is title case, convert out to title case
    if (is_title == TRUE) {
      out <- ToTitleCase(out)
    }
  }

  # return
  return(out)
}
