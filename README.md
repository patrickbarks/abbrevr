# abbrevr # 

An R package to abbreviate journal titles based on the ISO 4 standard.

An outline of the ISO 4 rules for abbreviation can be found [here](http://www.uai.cl/images/sitio/biblioteca/citas/ISO_4_1997en.pdf), and a text file containing the ISSN List of Title Word Abbreviations (LTWA) can be found [here](http://www.issn.org/services/online-services/access-to-the-ltwa).


## Installation

Install the development version from GitHub with:

```R
# install.packages("devtools")
devtools::install_github("patrickbarks/abbrevr")
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
