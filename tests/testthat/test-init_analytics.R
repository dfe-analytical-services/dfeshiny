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

test_that("GA key pulls into html", {
  output <- capture.output(init_analytics("TESTYTESTY", create_file = FALSE))

  # Expect the id to pull through on line 15
  expect_true(grepl("G-TESTYTESTY", output[15]))

  # Expect the id to pull through on line 22
  expect_true(grepl("G-TESTYTESTY", output[22]))

  # Expect to find a couple of other key parts
  expect_equal(output[1], "<script>")
  expect_true(grepl("window\\.dataLayer = window\\.dataLayer \\|\\| \\[\\]", output[3]))
  expect_true(grepl("window\\.dataLayer = window\\.dataLayer \\|\\| \\[\\]", output[17]))
  expect_true(grepl("function gtag\\(\\)\\{dataLayer\\.push\\(arguments\\)\\;\\}", output[4]))
  expect_true(grepl("function gtag\\(\\)\\{dataLayer\\.push\\(arguments\\)\\;\\}", output[18]))
})

test_that("Rejects non-boolean for create_file", {
  expect_error(init_analytics("TESTYTESTY", create_file = "Funky non-boolean"))
})
