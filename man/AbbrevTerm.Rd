% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AbbrevTerm.R
\name{AbbrevTerm}
\alias{AbbrevTerm}
\title{Abbreviate a word within a journal title based on the ISSN's List of Title
Word Abbreviations}
\usage{
AbbrevTerm(x, check = TRUE)
}
\arguments{
\item{x}{A single word from a journal title, in the form of a string.}

\item{check}{A logical indicating whether to check for an abbreviation (if
TRUE), or always return the original word (if FALSE). This is a convenience
argument that simplifies vectorization within the function
\code{AbbrevTitle}.}
}
\value{
A string reflecting the abbreviated form of \code{x}, or, if
  \code{check == FALSE} or no abbreviation is found, the original \code{x}.
}
\description{
Abbreviate a word within a journal title based on the ISSN's List of Title
Word Abbreviations (LTWA). \cr\cr NOTE: this function only abbreviates single
terms, not full titles. It is a helper function called by \code{AbbrevTitle}.
}
\examples{
AbbrevTerm("Canadian")
AbbrevTerm("journal")
AbbrevTerm("Entomology")
AbbrevTerm("medical")
AbbrevTerm("PLoS")
AbbrevTerm("Acuático")
AbbrevTerm("Investigación")
AbbrevTerm("Investigación", check = FALSE)

\dontrun{
# argument should be a single word (i.e. a string with no spaces)
# use function AbbrevTitle() to abbreviate a full title
AbbrevTerm("Canadian Journal of Entomology")
}
}
\seealso{
AbbrevTitle
}
\author{
Patrick Barks <patrick.barks@gmail.com>
}
