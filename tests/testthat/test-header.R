# create output for testing

test_that("outputs are as expected", {
  header_vector <- dfeshiny::header(header = "hello") |>
    unlist(use.names = FALSE)

  title_index <- header_vector |>
    stringr::str_which("govuk-header__content govuk-header__product-name") +
    1

  expect_equal(
    header_vector[title_index],
    "hello"
  )

  image_index <- header_vector |>
    stringr::str_which("img") +
    1

  expect_equal(
    header_vector[image_index],
    "dfeshiny/DfE_logo_landscape.png"
  )
})

test_that("Header handles additional shinyGovstyle header inputs", {
  header_vector <- header(
    "Site title",
    logo_alt_text = "Logo alt text"
  ) |>
    unlist(use.names = FALSE)
  expect_true(
    "Logo alt text" %in% header_vector
  )
})
