test_that("Accessibility dates are required", {
  expect_no_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th November 2024",
      date_prepared = "28th November 2024",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    )
  )
  expect_no_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26 November 2024",
      date_prepared = "28/11/2024",
      date_reviewed = "12-03-2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    )
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_prepared = "28th November 2024",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "argument \"date_tested\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/11/24",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "argument \"date_prepared\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th November 2024",
      date_prepared = "28th November 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "argument \"date_reviewed\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th November 2025",
      date_prepared = "28th November 2024",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "26th November 2025 is in the future."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "Geoff",
      date_prepared = "28th November 2024",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "Geoff not in a valid date format."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "Geoff",
      date_prepared = "28th November 2024",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "Geoff not in a valid date format."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th November 2024",
      date_prepared = "Bob",
      date_reviewed = "12th March 2024",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "Bob not in a valid date format."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26 November 2024",
      date_prepared = "28/11/24",
      date_reviewed = "Daisy",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "Daisy not in a valid date format."
  )
})

test_that("Accessibility name and URLs", {
  expect_error(
    a11y_panel(
      dashboard_url = "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/11/24",
      date_prepared = "28/11/24",
      date_reviewed = "12/03/24",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "argument \"dashboard_title\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      date_tested = "26/11/24",
      date_prepared = "28/11/24",
      date_reviewed = "12/03/24",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    "argument \"dashboard_url\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      dashboard_url = "Cecil",
      date_tested = "26/11/24",
      date_prepared = "28/11/24",
      date_reviewed = "12/03/24",
      repo_url = "https://github.com/dfe-analytical-services/shiny-template"
    ),
    paste("Cecil", "is not a valid DfE dashboard deployment URL")
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      dashboard_url = "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/11/24",
      date_prepared = "28/11/24",
      date_reviewed = "12/03/24",
      repo_url = "https://github.com/dfe-analytical-services/"
    ),
    paste("https://github.com/dfe-analytical-services/", "is not a valid repository url")
  )
})
