% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AbbrevTitle.R
\name{AbbrevTitle}
\alias{AbbrevTitle}
\title{Abbreviate a journal title using the ISO 4 standard}
\usage{
AbbrevTitle(x)
}
\arguments{
\item{x}{A journal title in the form of a string.}
}
\value{
A string reflecting the abbreviated form of \code{x}, based on the
  ISO 4 standard.
}
\description{
Abbreviate a journal title using the ISO 4 standard. \cr\cr A pdf outline of
the ISO 4 rules for abbreviation can be found at
\url{http://www.uai.cl/images/sitio/biblioteca/citas/ISO_4_1997en.pdf}, and a
text file containing the ISSN List of Title Word Abbreviations can be found
at \url{http://www.issn.org/services/online-services/access-to-the-ltwa}.
}
\examples{
AbbrevTitle("Journal of Great Lakes Research")
AbbrevTitle("Transactions of the American Fisheries Society")
AbbrevTitle("Journal of Chemical & Engineering Data")
AbbrevTitle("AT&T Technical Journal")
AbbrevTitle("Annalen der Physik")
AbbrevTitle("Deutsche Medizinische Wochenschrift")
AbbrevTitle("Les Annales du Théâtre et de la Musique")
AbbrevTitle("Revue d'Égyptologie")
AbbrevTitle("L'Intermédiaire des Mathématiciens")
}
\author{
Patrick Barks <patrick.barks@gmail.com>
}
