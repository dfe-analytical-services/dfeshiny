test_that("email needs to follow standard pattern", {
  expect_error(support_panel(team_email = "thisshoulfail@something"))
  expect_no_error(support_panel(team_email = "thisshouldpass@something.com"))
})
