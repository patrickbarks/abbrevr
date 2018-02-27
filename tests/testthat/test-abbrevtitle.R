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
})
