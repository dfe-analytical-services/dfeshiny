# To run the diffviewer on these tests, you need to add the path:
# Doesn't work? testthat::snapshot_review('UI-03-external_link/', path='tests/test_dashboard/')
app <- AppDriver$new(expect_values_screenshot_args = FALSE)

app$wait_for_idle(50)
