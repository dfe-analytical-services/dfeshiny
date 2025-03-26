test_that("Bookmark works", {
  # Start local app in the background in test mode
  bg_app <- shinytest2::AppDriver$new(paste0(getwd(), "tests/test_dashboard"))
  # Capture the background app's URL and add appropriate query parameters
  bookmark_url <- paste0(bg_app$get_url(), "?_inputs_&n=10")
  # Open the bookmark URL in a new AppDriver object
  app <- shinytest2::AppDriver$new(bookmark_url)

  # Run your tests on the bookmarked `app`
  app$expect_values()
})
