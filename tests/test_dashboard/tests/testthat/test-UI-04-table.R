app <- AppDriver$new(
  name = "table_example",
  expect_values_screenshot_args = FALSE
)

app$wait_for_idle(50)

test_that("Table renders as expected", {
  # Check the initial rendering of the table
  app$wait_for_idle(50)
  app$expect_values(output = "reactable_example")
})
