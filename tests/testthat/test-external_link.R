# Create a test link ==========================================================
test_link <- external_link("https://shiny.posit.co/", "R Shiny")

# Run rest of tests against the test link -------------------------------------
test_that("Returns shiny.tag object", {
  expect_s3_class(test_link, "shiny.tag")
})

test_that("content and URL are correctly formatted", {
  expect_equal(test_link$attribs$href, "https://shiny.posit.co/")
  expect_true(grepl("R Shiny", test_link$children[[2]]))
})

test_that("New tab warning appends", {
  expect_true(grepl("\\(opens in new tab\\)", test_link$children[[2]]))
})

test_that("attributes are attached properly", {
  expect_equal(test_link$attribs$rel, "noopener noreferrer")
  expect_equal(test_link$attribs$target, "_blank")
})

test_that("hidden text is skipped", {
  expect_true(is.null(test_link$children[[1]]))
})

# Rest of tests against the function ==========================================
test_that("Rejects dodgy link text", {
  expect_error(external_link("https://shiny.posit.co/", "Click here"))
  expect_error(external_link("https://shiny.posit.co/", "here"))
  expect_error(external_link("https://shiny.posit.co/", "PDF"))
  expect_error(external_link("https://shiny.posit.co/", "https://shiny.posit.co/"))
  expect_error(external_link("https://shiny.posit.co/", "http://shiny.posit.co/"))
  expect_error(external_link("https://shiny.posit.co/", "www.google.com"))
})

test_that("Rejects non-boolean for add_warning", {
  expect_error(
    external_link(
      "https://shiny.posit.co/",
      "R Shiny",
      add_warning = "Funky non-boolean"
    ),
    "add_warning must be a TRUE or FALSE value"
  )
})

test_that("New tab warning always stays for non-visual users", {
  test_link_hidden <-
    external_link("https://shiny.posit.co/", "R Shiny", add_warning = FALSE)

  expect_true(
    grepl("This link opens in a new tab", test_link_hidden$children[[1]])
  )
})
