library(shinytest2)

# To run the diffviewer on these tests, you need to add the path:
# testthat::snapshot_review('cookie-auth/', path='tests/test_dashboard/')

app <- AppDriver$new(
  name = "cookie_consent",
  height = 846,
  width = 1445,
  load_timeout = 45 * 1000,
  timeout = 20 * 1000,
  wait = TRUE
)

app$wait_for_idle(500)

app$click("cookie_consent_clear")
test_that("App loads", {
  # Capture initial values
  app$expect_values(  )
})

app$click("cookies-cookie_accept")
test_that("Cookies accepted", {
  # Capture initial values
  app$expect_values(  )
})

app$click("cookie_consent_clear")
test_that("Cookies reset", {
  # Capture initial values
  app$expect_values()
})

app$click("cookies-cookie_reject")
test_that("Cookies rejected", {
  # Capture initial values
  app$expect_values(  )
})
