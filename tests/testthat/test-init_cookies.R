test_that("Rejects non-boolean for create_file", {
  expect_error(init_cookies(create_file = "Funky non-boolean"))
})

test_that("Javascript writes out", {
  output <- capture.output(init_cookies(create_file = FALSE))

  # Expect to find a couple of other key parts
  expect_equal(output[1], "function getCookies(){")
  expect_true(grepl("Shiny\\.setInputValue\\('cookies'", output[3]))
  expect_true(grepl("cookie-set", output[6]))
  expect_true(grepl("cookie-clear", output[11]))
  expect_true(grepl("analytics-consent", output[20]))
})
