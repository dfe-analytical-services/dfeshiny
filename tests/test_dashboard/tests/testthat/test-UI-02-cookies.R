# To run the diffviewer on these tests, you need to add the path:
# Doesn't work? testthat::snapshot_review('cookie-auth/', path='tests/test_dashboard/')
app <- AppDriver$new(
  name = "cookies_consent",
  height = 846,
  width = 1445,
  load_timeout = 45 * 1000,
  timeout = 20 * 1000,
  wait = TRUE,
  expect_values_screenshot_args = FALSE
)

app$wait_for_idle(5)

app$click("cookies_banner-cookies_accept")
test_that("Cookies accepted banner", {
  # Capture initial values
  app$expect_values()
})

app$click("cookies_banner-cookies_reject")
test_that("Cookies rejected banner", {
  # Capture initial values
  app$expect_values()
})

app$set_inputs(`cookies_panel-cookies_analytics` = "yes")
app$click("cookies_panel-submit_btn")
test_that("Cookies accepted page", {
  # Capture initial values
  app$expect_values()
})

app$set_inputs(`cookies_panel-cookies_analytics` = "no")
app$click("cookies_panel-submit_btn")
test_that("Cookies rejected page", {
  # Capture initial values
  app$expect_values()
})
