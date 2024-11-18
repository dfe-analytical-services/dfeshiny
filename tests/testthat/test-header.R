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
    "/dfeshiny/DfE_logo_landscape.png"
  )
})
