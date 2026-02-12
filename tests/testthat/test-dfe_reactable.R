test_that("dfe_reactable produces a properly configured reactable object", {
  # Generate a small sample dataset
  sample_data <- data.frame(
    Name = c("Alice", "Bob", "Charlie"),
    Age = c(25, 30, 35),
    Score = c(85.5, 90.3, 88.7)
  )

  # Run the function
  table_output <- dfe_reactable(sample_data)

  # Test if the output is a reactable object
  expect_s3_class(table_output, "reactable")
  expect_s3_class(table_output, "htmlwidget")

  # Check the main attributes
  expect_type(table_output$x, "list")
  expect_true("tag" %in% names(table_output$x))

  # Check the tag attribs
  attribs <- table_output$x$tag$attribs
  expect_type(attribs, "list")

  # Validate the widget's overall class and package
  expect_equal(attr(table_output, "class"), c("reactable", "htmlwidget"))
  expect_equal(attr(table_output, "package"), "reactable")

  # Take snapshot of table HTML
  output_html <- htmltools::renderTags(table_output)$html

  # Prevent unnecessary changes due to random IDs
  stripped_ids <- gsub('"htmlwidget-[^"]*"', "", output_html)

  expect_snapshot(stripped_ids)
})
