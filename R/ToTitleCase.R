#' Convert a single word to title case
#'
#' @param x A single word in the form of a string.
#' @return The original string, but with the first character capitalized.
#' @author Patrick Barks <patrick.barks@@gmail.com>
#' @examples
#' ToTitleCase('quebec')
#' @export ToTitleCase
ToTitleCase <- function(x) {
  paste0(toupper(substr(x, 1, 1)), substr(x, 2, nchar(x)))
}
