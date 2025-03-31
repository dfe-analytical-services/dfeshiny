test_that("Bookmark works", {
  bg_app <- shinytest2::AppDriver$new("../test_dashboard")
  # Capture the background app's URL and add appropriate query parameters
  bookmark_url <- paste0(bg_app$get_url(), "?_inputs_&navlistPanel=support_panel")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url)
  # Run your tests on the bookmarked `app`
  app$expect_values()

  bookmark_url <- paste0(bg_app$get_url(), "?_inputs_&navlistPanel=a11y_panel")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url)
  # Run your tests on the bookmarked `app`
  app$expect_values()

  bookmark_url <- paste0(bg_app$get_url(), "?_inputs_&navlistPanel=cookies_panel_ui")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url)
  # Run your tests on the bookmarked `app`
  app$expect_values()
})
