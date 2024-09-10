test_that("Returns data frame", {
  expect_true(is.data.frame(dfeshiny::bad_link_text))
})

test_that("Matches description", {
  # If this test fails, update the notes in R/data-bad_link_text.R
  expect_equal(nrow(dfeshiny::bad_link_text), 52)
  expect_equal(names(dfeshiny::bad_link_text), "bad_link_text")
})

test_that("All are string values", {
  expect_true(all(sapply(dfeshiny::bad_link_text$bad_link_text, is.character)))
})

test_that("Is all lower case", {
  expect_true(all(
    dfeshiny::bad_link_text$bad_link_text ==
      tolower(dfeshiny::bad_link_text$bad_link_text)
  ))
})

test_that("There are no duplicates", {
  expect_true(!anyDuplicated(dfeshiny::bad_link_text))
})
