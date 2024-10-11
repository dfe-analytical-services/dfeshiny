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
  expect_error(support_panel(team_email = "cam@education.gov.uk"))
})

# Testing extra text inputs

text_example <- "This is a text"

test_that("testing extra text input", {
  # testing extra text input for feedback section
  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_extra_txt = text_example,
  ))
  # testing extra text input for find out more information section

  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    info_extra_txt = text_example,
  ))

  # testing extra text input for contact us section

  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    contact_extra_txt = text_example
  ))

  # testing extra text input for all sections
  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_extra_txt = text_example,
    info_extra_txt = text_example,
    contact_extra_txt = text_example
  ))
})

# Example output object =======================================================
# This is used in the following tests

output <- support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com"
)

test_that("Output has class 'shiny.tag'", {
  expect_s3_class(output, class = "shiny.tag")
})

test_that("HTML headings output from function", {
  # This checks the headings are in the expected positions in the HTML output the function returns
  expect_equal(paste(output$children[[1]]), "<h1>Support and feedback</h1>")
  expect_equal(paste(output$children[[2]]), "<h2>Give us feedback</h2>")
  expect_equal(paste(output$children[[4]]), "<h2>Find more information on the data</h2>")
  expect_equal(paste(output$children[[6]]), "<h2>Contact us</h2>")
  expect_equal(paste(output$children[[8]]), "<h2>See the source code</h2>")
})
