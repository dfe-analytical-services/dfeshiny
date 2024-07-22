test_that("Blank code throws error", {
  expect_error(init_analytics())
})

test_that("Long code throws error", {
  expect_error(init_analytics("G-qwertyuiop"))
})

test_that("Short code throws error", {
  expect_error(init_analytics("qwerty"))
})

test_that("Numeric throws error", {
  expect_error(init_analytics(1234567890))
})
