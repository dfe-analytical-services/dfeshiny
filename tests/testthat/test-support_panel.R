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

# Testing custom text inputs

text_example <- "This is a text"

test_that("testing custom text input", {
  # testing custom text input for feedback section
  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_custom_text = text_example,
  ))
  # testing custom text input for find out more information section

  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    info_custom_text = text_example,
  ))

  # testing custom text input for contact us section

  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    contact_custom_text = text_example
  ))

  # testing custom text input for all sections
  expect_no_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_custom_text = text_example,
    info_custom_text = text_example,
    contact_custom_text = text_example
  ))
})

# Testing errors for adding combined custom text with no tagList wrapper

test_that("Adding custom text with c() produces an error", {
  expect_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_custom_text = c("x", "y")
  ))

  expect_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    info_custom_text = c("k", "r"),
  ))

  expect_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    contact_custom_text = c("a", "b")
  ))
  expect_error(support_panel(
    team_email = "menna@education.gov.uk",
    repo_name = "https://github.com/dfe-analytical-services/my-repo",
    feedback_custom_text = c("x", "y"),
    info_custom_text = c("k", "r"),
    contact_custom_text = c("a", "b")
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
  expect_equal(paste(output$children[[7]]), "<h2>Contact us</h2>")
  expect_equal(paste(output$children[[9]]), "<h2>See the source code</h2>")
})


output <- support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com",
  feedback_custom_text = "test text",
  info_custom_text = "test text",
  contact_custom_text = "test text"
)

test_that("Custom texts outputs", {
  # This checks the custom text inputs are in the expected positions
  # in the HTML output the function returns
  expect_equal(paste(output$children[[3]]), "<p>test text</p>")
  expect_equal(paste(output$children[[5]]), "<p>test text</p>")
  expect_equal(paste(output$children[[8]]), "<p>test text</p>")
})

output <- support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com",
  feedback_custom_text = "test text",
  extra_text = html_paragraph_tags(
    heading = "heading text",
    body = "body text"
  )
)

test_that("Extra texts outputs", {
  # This checks the custom text inputs are in the expected positions
  # in the HTML output the function returns
  expect_equal(paste(output$children[[6]][[1]]), "<h2>heading text</h2>")
  expect_equal(paste(output$children[[6]][[2]]), "<p>body text</p>")
})
