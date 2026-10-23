test_that("Header contains the organisation, service name and primary logo", {
  output <- dfeshiny::header(header = "hello")
  query <- htmltools::tagQuery(output)

  service <- query$find(".govuk-header__service-name")$selectedTags()
  expect_length(service, 1)
  expect_equal(service[[1]]$children[[1]], "hello")

  primary_logo <- query$find(".govuk-header__logo")$selectedTags()[[1]]
  expect_null(primary_logo$attribs$`aria-hidden`)
  logo_query <- htmltools::tagQuery(primary_logo)
  organisation <- logo_query$find(".govuk-header__product-name")$selectedTags()
  expect_equal(organisation[[1]]$children[[1]], "Department for Education")

  images <- logo_query$find("img")$selectedTags()
  expect_length(images, 1)
  expect_equal(images[[1]]$attribs$src, "shinyGovstyle/images/Dept_logo.svg")
})

test_that("Header handles additional shinyGovstyle header inputs", {
  output <- header("Site title", logo_alt_text = "Logo alt text")
  primary_logo <- htmltools::tagQuery(output)$find(".govuk-header__logo")$selectedTags()[[1]]
  image <- htmltools::tagQuery(primary_logo)$find("img")$selectedTags()[[1]]

  expect_equal(image$attribs$alt, "Logo alt text")
})
