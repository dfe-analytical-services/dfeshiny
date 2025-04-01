bg_app <- AppDriver$new(
  name = "bookmarking",
  expect_values_screenshot_args = FALSE
)

base_url <- bg_app$get_url()

test_that("A11y panel bookmark test", {
  # Run your tests on the bookmarked `app`
  bookmark_url <- paste0(base_url, "?_inputs_=&navlistPanel=\"a11y_panel\"")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url, name = "a11y_panel")
  app$expect_values()
})

test_that("Cookies panel bookmark test", {
  # Run your tests on the bookmarked `app`
  bookmark_url <- paste0(base_url, "?_inputs_=&navlistPanel=\"cookies_panel_ui\"")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url, name = "cookies_panel")
  app$expect_values()
})

test_that("Table panel bookmark test", {
  # Run your tests on the bookmarked `app`
  bookmark_url <- paste0(base_url, "?_inputs_=&navlistPanel=\"table_panel_ui\"")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url, name = "table_panel")
  app$expect_values()
})
