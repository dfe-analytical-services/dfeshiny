# create output for testing

output <- dfeshiny::header(header = "hello")


test_that("outputs are as expected", {
  expect_equal(
    paste(
      output$children[[2]]$children[[2]]$children[[1]]$children[[1]]
    ),
    "hello"
  )

  expect_equal(
    paste(
      output[["children"]][[2]][["children"]][[1]][["children"]][[1]]
      [["children"]][[1]][["children"]][[1]][["attribs"]][["src"]]
    ),
    "dfeshiny/DfE_logo_landscape.png"
  )
})

test_that("Header handles additional shinyGovstyle header inputs", {
  expect_equal(
    header(
      "Site title",
      secondary_link = "https://explore-education-statistics.service.gov.uk/"
    )$children[[2]][[3]][[2]][[3]][[1]]$attribs$href,
    "https://explore-education-statistics.service.gov.uk/"
  )
}
)
