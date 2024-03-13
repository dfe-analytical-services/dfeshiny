test_that("Blank code throws error", {
  expect_error(initialise_analytics())
})

test_that("Long code throws error", {
  expect_error(initialise_analytics("G-qwertyuiop"))
})

test_that("Short code throws error", {
  expect_error(initialise_analytics("qwerty"))
})

test_that("Numeric throws error", {
  expect_error(initialise_analytics(1234567890))
})
