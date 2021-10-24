library(testthat)
library(abbrevr)

context("Title abbreviations")

test_that("Correct abbreviation for easy English-language titles", {
  expect_equal(AbbrevTitle("Science"), "Science")
  expect_equal(AbbrevTitle("Journal of Ecology"), "J. Ecol.")
  expect_equal(AbbrevTitle("Journal of Evolutionary Biology"), "J. Evol. Biol.")
  expect_equal(AbbrevTitle("American Journal of Epidemiology"), "Am. J. Epidemiol.")
  expect_equal(AbbrevTitle("Annual Review of Ecology and Systematics"), "Annu. Rev. Ecol. Syst.")
  expect_equal(AbbrevTitle("PLoS ONE"), "PLoS ONE")

  # examples previously returning term 'NANA' (issue #2)
  expect_equal(AbbrevTitle("ACS Photonics"), "ACS Photonics")
  expect_equal(AbbrevTitle("Biomass & Bioenergy"), "Biomass Bioenergy") # should '&' be retained here?
  expect_equal(AbbrevTitle("Journal of Cereal Science"), "J. Cereal Sci.")
  expect_equal(AbbrevTitle("Rivista Italiana Delle Sostanze Grasse"), "Riv. Ital. Delle Sostanze Grasse")
  expect_equal(AbbrevTitle("Science and Engineering Ethics"), "Sci. Eng. Ethics")
})

test_that("Correct abbreviation for titles with matching multi-word phrases", {
  expect_equal(AbbrevTitle("The Journal of the Anthropological Institute of Great Britain and Ireland"),
               "J. Anthropol. Inst. G. B. Irel.")
  expect_equal(AbbrevTitle("Journal of North American Herpetology"),
               "J. N. Am. Herpetol.")
  expect_equal(AbbrevTitle("Journal of Great Lakes Research"),
               "J. Gt. Lakes Res.")
  expect_equal(AbbrevTitle("Transactions of the New York Academy of Sciences"),
               "Trans. N. Y. Acad. Sci.")
})
