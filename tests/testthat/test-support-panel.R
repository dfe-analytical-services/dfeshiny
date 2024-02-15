test_that("email needs to follow standard pattern", {
  # Test that a @education.gov.uk passes
  expect_no_error(support_panel(team_email = "cam@education.gov.uk"))
  expect_no_error(support_panel(team_email = "cam1.race@education.gov.uk"))

  # Testing that it will fail if it follows the something@domain.ending pattern
  expect_error(support_panel(team_email = "thisshouldpass@something.com"))
  expect_error(support_panel(team_email = "this.should.pass@something.com"))

  # Testing that it will fail if there is no final dot and section
  expect_error(support_panel(team_email = "thisshoulfail@something"))

  # Test Wales will fail
  expect_error(support_panel(team_email = "thisshouldpass@something.wales"))

  # Test that it fails if there is no @ symbol
  expect_error(support_panel(team_email = "team.team"))
})
