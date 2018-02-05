# abbrevr # 

An R package to abbreviate journal titles based on the ISO 4 standard.

An outline of the ISO 4 rules for abbreviation can be found [here](http://www.uai.cl/images/sitio/biblioteca/citas/ISO_4_1997en.pdf), and a text file containing the ISSN List of Title Word Abbreviations (LTWA) can be found [here](http://www.issn.org/services/online-services/access-to-the-ltwa).


## Installation

Install the development version from GitHub with:

```R
# install.packages("devtools")
devtools::install_github("patrickbarks/abbrevr")
```

## Usage

Abbreviate individual titles:

```R
library(abbrevr)

AbbrevTitle("Transactions of the American Fisheries Society")
AbbrevTitle("Deutsche Medizinische Wochenschrift")
AbbrevTitle("L'Intermédiaire des Mathématiciens")
```

Use [rcrossref](https://github.com/ropensci/rcrossref) library to extract citation info for a set of DOIs, then abbreviate journal titles using abbrevr:


```R
# load rcrossref and abbrevr libraries
library(rcrossref)
library(abbrevr)


# DOIs for a set of scientific publications
dois <- c("10.1577/T09-174.1",
          "10.1371/journal.pone.0075858",
          "10.1111/1365-2435.12359",
          "10.1111/jeb.12823",
          "10.1111/1365-2745.12937")

# use rcrossref::cr_cn() to get citation info for DOIs
citations <- rcrossref::cr_cn(dois, format = "citeproc-json")

# extract journal titles from citation info
titles <- sapply(citations, function(x) x$`container-title`, USE.NAMES = FALSE)

# use abbrevr::AbbrevTitle() to abbreviate titles
titles_short <- sapply(titles, abbrevr::AbbrevTitle, USE.NAMES = FALSE)

# print data.frame
data.frame(doi = my_dois,
           title = my_titles,
           title_short = my_titles_short,
           stringsAsFactors = FALSE)

>                          doi                                          title           title_short
>            10.1577/T09-174.1 Transactions of the American Fisheries Society Trans. Am. Fish. Soc.
> 10.1371/journal.pone.0075858                                       PLoS ONE              PLoS ONE
>      10.1111/1365-2435.12359                             Functional Ecology          Funct. Ecol.
>            10.1111/jeb.12823                Journal of Evolutionary Biology        J. Evol. Biol.
>      10.1111/1365-2745.12937                             Journal of Ecology              J. Ecol.
```

## Caveats

The current version... 
* only handles common articles, prepositions, and conjunctions in English, German, and French. (ISO 4 dictates that these classes should generally be ommitted, with exceptions noted in the document linked above)
* omits all punctuation except for hyphens, and periods following abbreviated terms (ISO 4 dictates all punctuation except commas should be retained, but periods should be replaced with commas)
* does not omit generic identifiers such as "Section", "Series", or "Part" (ISO 4 dictates such generics should be ommitted unless required for identification)
* may not retain all diacritic marks (ISO 4 dictates that all diacritic marks should be retained)

Also beware of abbreviation rules that are difficult to implement algorithmically, e.g.:
* names of persons should not be abbreviated
* prepositions and articles should be retained if they are integral parts of proper names (e.g. "Los Alamos") or locutions (e.g. "in vivo")
