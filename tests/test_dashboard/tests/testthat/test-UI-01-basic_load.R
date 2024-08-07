# To run the diffviewer on these tests, you need to add the path:
# Doesn't work? testthat::snapshot_review('cookie-auth/', path='tests/test_dashboard/')
app <- AppDriver$new(
  name = "basic_load",
  height = 846,
  width = 1445,
  load_timeout = 45 * 1000,
  timeout = 20 * 1000,
  wait = TRUE,
  expect_values_screenshot_args = TRUE
)

app$wait_for_idle(5)

test_that("App loads", {
  # Capture all values as it's a very basic app
  app$expect_values()
})
