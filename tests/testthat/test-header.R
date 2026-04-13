# Suppress known deprecation warnings
header_output <- suppressWarnings(header(header = "hello"))

test_that("outputs are as expected", {
  # Helper to recursively search for a tag by class
  find_tag_by_class <- function(x, class_name) {
    if (
      is.list(x) && !is.null(x$attribs$class) && x$attribs$class == class_name
    ) {
      return(x)
    }
    if (is.list(x) && !is.null(x$children)) {
      for (child in x$children) {
        found <- find_tag_by_class(child, class_name)
        if (!is.null(found)) return(found)
      }
    }
    NULL
  }

  product_name <- find_tag_by_class(header_output, "govuk-header__product-name")
  expect_false(is.null(product_name))
  expect_equal(product_name$children[[1]], "Department for Education")

  logo_img <- find_tag_by_class(
    header_output,
    "govuk-header__logotype-crown-fallback-image"
  )
  if (!is.null(logo_img) && identical(logo_img$name, "img")) {
    expect_equal(logo_img$attribs$src, "dfeshiny/DfE_logo_landscape.png")
  }
})

test_that("Snapshot is as expected", {
  expect_snapshot(header_output)
})
