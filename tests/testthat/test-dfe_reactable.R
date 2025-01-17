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

  # Verify key preconfigured attributes
  expect_equal(attribs$resizable, TRUE)
  expect_equal(attribs$highlight, TRUE)
  expect_equal(attribs$borderless, TRUE)
  expect_equal(attribs$showSortIcon, FALSE)

  # Verify column definitions
  columns <- attribs$columns
  expect_equal(length(columns), 3) # Ensure 3 columns are defined

  # Validate the first column's attributes
  col1 <- columns[[1]]
  expect_equal(col1$id, "Name")
  expect_equal(col1$name, "Name")
  expect_equal(col1$type, "character")
  expect_equal(col1$html, TRUE)
  expect_equal(col1$headerClassName, "govuk-table__header")

  # Validate language configuration
  language <- attribs$language
  expect_type(language, "list")
  expect_equal(language$searchPlaceholder, "Search table...")

  # Validate theme configuration
  theme <- attribs$theme
  expect_type(theme, "list")
  expect_equal(theme$searchInputStyle$float, "right")
  expect_equal(theme$searchInputStyle$width, "25%")
  expect_equal(theme$searchInputStyle$border, "1px solid #ccc")

  # Validate the widget's overall class and package
  expect_equal(attr(table_output, "class"), c("reactable", "htmlwidget"))
  expect_equal(attr(table_output, "package"), "reactable")
})
