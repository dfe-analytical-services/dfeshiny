test_that("email needs to follow standard pattern", {
  # Test that a @education.gov.uk passes
  expect_no_error(
    support_panel(
      team_email = "cam@education.gov.uk",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )
  expect_no_error(
    support_panel(
      team_email = "cam1.race@education.gov.uk",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )

  # Testing that it will fail if it follows the something@domain.ending pattern
  expect_error(
    support_panel(
      team_email = "thisshouldpass@something.com",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )
  expect_error(
    support_panel(
      team_email = "this.should.pass@something.com",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )

  # Testing that it will fail if there is no final dot and section
  expect_error(
    support_panel(
      team_email = "thisshoulfail@something",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )

  # Test Wales will fail
  expect_error(
    support_panel(
      team_email = "thisshouldpass@something.wales",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )

  # Test that it fails if there is no @ symbol
  expect_error(
    support_panel(
      team_email = "team.team",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )
})

test_that("repo URL needs to follow standard pattern", {
  # Test that a github repo in dfe analytical services passes
  expect_no_error(
    support_panel(
      team_email = "cam@education.gov.uk",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny"
    )
  )

  # Testing that it will fail if it's on GitHub but not in DfE area
  expect_error(
    support_panel(
      team_email = "cam@education.gov.uk",
      repo_name = "https://github.com/cjrace/dfeR"
    )
  )
  expect_error(
    support_panel(
      team_email = "cam@education.gov.uk",
      repo_name = "https://github.com/DfE-R-Community/ggdfe"
    )
  )

  # Testing that it will fail if there is no final dot and section
  expect_error(
    support_panel(
      team_email = "cam@education.gov.uk",
      repo_name = "https://explore-education-statistics.service.gov.uk/"
    )
  )

  # Testing that it will fail if there is no repo_name
  expect_error(
    support_panel(
      team_email = "cam@education.gov.uk"
    )
  )
})
