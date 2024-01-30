test_that("email needs to follow standard pattern", {
  # Testing that it will pass if it follows the something@domain.ending pattern
  expect_no_error(support_panel(team_email = "thisshouldpass@something.com"))
  expect_no_error(support_panel(team_email = "this.should.pass@something.com"))


  # Testing that it will fail if there is no final dot and section
  expect_error(support_panel(team_email = "thisshoulfail@something"))

  # Test Wales is accepted
  expect_no_error(support_panel(team_email = "thisshouldpass@something.wales"))

  # Test that it fails if there is no @ symbol
  expect_error(support_panel(team_email = "team.team"))
})
