
# create output for testing

output <- dfeshiny::footer_dfe(full = FALSE)


test_that("outputs are as expected", {
  expect_equal(
    paste(
      output$attribs$class
    ),
    "govuk-footer "
  )

  expect_equal(
    paste(
      ifelse(
        grepl( "govuk-footer__meta-item govuk-footer__meta-item--grow",
               output$children,
               fixed = TRUE),
        1,
        0)
      ),
    "1"
  )
})

output2 <- dfeshiny::footer_dfe(full = TRUE)

test_that("outputs are as expected", {
  expect_equal(
    paste(
      output2$attribs$class
    ),
    "govuk-footer "
  )

  expect_equal(
    paste(
      ifelse(
        grepl( "Accessibility information",
               output2$children,
               fixed = TRUE),
        1,
        0)
    ),
    "1"
  )

  expect_equal(
    paste(
      ifelse(
        grepl( "govuk-footer__link",
               output2$children,
               fixed = TRUE),
        1,
        0)
    ),
    "1"
  )
})



