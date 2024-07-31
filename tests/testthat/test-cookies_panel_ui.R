# Example output object =======================================================
# This is used in the following tests
output <- cookies_panel_ui(google_analytics_key = "TESTYTESTY")

test_that("Output has class 'shiny.tag'", {
  expect_s3_class(output, class = "shiny.tag")
})

test_that("HTML headings output from function", {
  # This checks the headings are in the expected positions in the HTML output the function returns
  expect_equal(paste(output$children[[1]]), "<h1>Cookies</h1>")
  expect_equal(paste(output$children[[4]]), "<h2>Essential cookies</h2>")
  expect_equal(paste(output$children[[6]]), "<h2>Analytics cookies</h2>")
  expect_equal(paste(output$children[[13]]), "<h2>Change your cookie settings</h2>")
})

test_that("GA key pulls into table output", {
  expect_true(grepl("_ga_TESTYTESTY", paste(output$children[[11]])))
})
