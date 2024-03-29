test_that("publication link is valid", {
  # Test that an EES publication link passes
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  # Test that a gov.uk publication link passes
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://www.gov.uk/government/collections/job-and-skills-data" # nolint: [line_length_linter]
    )
  )

  # Test that it fails for non-existent links/typos/random links
  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/hello" # nolint: [line_length_linter]
    )
  )

  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://www.bbc.com/news"
    )
  )

  # Test that just linking to EES homepage fails

  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/" # nolint: [line_length_linter]
    )
  )
})

test_that("site links are valid", {
  # Test that valid long shinyapps.io link pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  # Test that valid short shinyapps.io link pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  # Test that a list of valid shinyapps.io links pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/", # nolint: [line_length_linter]
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/", # nolint: [line_length_linter]
        "https://department-for-education.shinyapps.io/dfe-shiny-template/" # nolint: [line_length_linter]
      ),
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  # Test that it fails for non-shinyapps.io links
  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools", # nolint: [line_length_linter]
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools", # nolint: [line_length_linter]
        "https://department-for-education.shinyapps.io/dfe-shiny-template/" # nolint: [line_length_linter]
      ),
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )

  # Test that it fails for a link to shinyapps.io with no suffix
  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/"
      ),
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    )
  )
})
