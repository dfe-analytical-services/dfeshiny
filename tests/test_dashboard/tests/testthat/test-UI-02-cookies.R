# To run the diffviewer on these tests, you need to add the path:
# testthat::snapshot_review('UI-02-cookies/', path='tests/test_dashboard/tests/testthat')
app <- AppDriver$new(
  name = "cookies_consent",
  expect_values_screenshot_args = FALSE
)

app$wait_for_idle(50)

test_that("Can click view cookie information", {
  app$click("cookies_banner-cookies_link")
  app$wait_for_idle(50)
  app$expect_values()
})

test_that("Cookies accepted banner", {
  app$click("cookies_banner-cookies_accept")
  app$wait_for_idle(50)
  app$expect_values()
})


test_that("Cookies rejected banner", {
  app$click("cookies_banner-cookies_reject")
  app$wait_for_idle(50)
  app$expect_values()
})

test_that("Cookies accepted page", {
  app$set_inputs(`cookies_panel-cookies_analytics` = "yes")
  app$wait_for_idle(50)
  app$click("cookies_panel-submit_btn")
  app$wait_for_idle(50)
  app$expect_values()
})

test_that("Cookies rejected page", {
  app$set_inputs(`cookies_panel-cookies_analytics` = "no")
  app$wait_for_idle(50)
  app$click("cookies_panel-submit_btn")
  app$wait_for_idle(50)
  app$expect_values()
})
