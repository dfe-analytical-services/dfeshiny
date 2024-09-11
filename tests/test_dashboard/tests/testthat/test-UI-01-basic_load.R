# To run the diffviewer on these tests, you need to add the path:
# Doesn't work? testthat::snapshot_review('UI-01-basic_load/', path='tests/test_dashboard/')
app <- AppDriver$new(expect_values_screenshot_args = FALSE)

app$wait_for_idle(5)

test_that("App loads", {
  # Capture all values as it's a very basic app
  app$expect_values()
})
