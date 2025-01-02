test_that("Accessibility dates are required", {
  expect_no_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th March 2024",
      date_prepared = "28th March 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    )
  )
  expect_no_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26 March 2024",
      date_prepared = "28/03/2024",
      date_reviewed = "12-11-2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    )
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_prepared = "28th March 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "argument \"date_tested\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/03/24",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "argument \"date_prepared\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th November 2024",
      date_prepared = "28th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "argument \"date_reviewed\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th March 2099",
      date_prepared = "28th March 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "\"26th March 2099\" is in the future."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "13/11/2023",
      date_prepared = "28th November 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "date_reviewed should be later than date_prepared"
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "13/11/2024",
      date_prepared = "28th March 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "date_reviewed should be later than date_tested"
  )
  expect_warning(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "13/03/2020",
      date_prepared = "28th March 2020",
      date_reviewed = "12th November 2020",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    paste0(
      "The template has been through a review more recently than your dashboard, please get in ",
      "touch with the explore education statistics platforms team to request a re-review."
    )
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "Geoff",
      date_prepared = "28th March 2024",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "\"Geoff\" is not in a valid date format, e.g. 8th August 2024 or 08/08/2024."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26th March 2024",
      date_prepared = "Bob",
      date_reviewed = "12th November 2024",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "\"Bob\" is not in a valid date format, e.g. 8th August 2024 or 08/08/2024."
  )
  expect_error(
    a11y_panel(
      "DfE Shiny template",
      "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26 November 2024",
      date_prepared = "28/11/24",
      date_reviewed = "Daisy",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "\"Daisy\" is not in a valid date format, e.g. 8th August 2024 or 08/08/2024."
  )
})

test_that("Accessibility name and URLs", {
  expect_error(
    a11y_panel(
      dashboard_url = "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/03/24",
      date_prepared = "28/03/24",
      date_reviewed = "12/11/24",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "argument \"dashboard_title\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      date_tested = "26/03/24",
      date_prepared = "28/03/24",
      date_reviewed = "12/11/24",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    "argument \"dashboard_url\" is missing, with no default"
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      dashboard_url = "Cecil",
      date_tested = "26/03/24",
      date_prepared = "28/03/24",
      date_reviewed = "12/11/24",
      issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
    ),
    paste("Cecil", "is not a valid DfE dashboard deployment URL")
  )
  expect_error(
    a11y_panel(
      dashboard_title = "DfE Shiny template",
      dashboard_url = "https://department-for-education.shinyapps.io/dfe-shiny-template",
      date_tested = "26/03/24",
      date_prepared = "28/03/24",
      date_reviewed = "12/11/24",
      issues_contact = "https://github.com/dfe-analytical-services/"
    ),
    paste0(
      "\"",
      "https://github.com/dfe-analytical-services/",
      "\"",
      " should either be a valid repository URL or a valid DfE e-mail address"
    )
  )
})

output <- a11y_panel(
  "DfE Shiny template",
  "https://department-for-education.shinyapps.io/dfe-shiny-template",
  date_tested = "26th March 2024",
  date_prepared = "28th March 2024",
  date_reviewed = "12th November 2024",
  issues_contact = "https://github.com/dfe-analytical-services/shiny-template/issues"
)

test_that("HTML headings output from function", {
  # This checks the headings are in the expected positions in the HTML output the function returns
  expect_equal(
    paste(output$children[[1]]),
    "<h1>Accessibility statement for DfE Shiny template</h1>"
  )
  expect_equal(
    paste(output$children[[3]]),
    "<h2>How you should be able to use this website</h2>"
  )
  expect_equal(paste(output$children[[8]]), "<h2>How accessible this website is</h2>")
  expect_equal(
    paste(output$children[[10]]),
    "<h2>Feedback and contact information</h2>"
  )
  expect_equal(paste(output$children[[14]]), "<h2>Enforcement procedure</h2>")
  expect_equal(
    paste(output$children[[17]]),
    "<h2>Technical information about this website's accessibility</h2>"
  )
  expect_equal(paste(output$children[[19]]), "<h3>Compliance status</h3>")
  expect_equal(paste(output$children[[21]]), "<h3>Disproportionate burden</h3>")
  expect_equal(paste(output$children[[23]]), "<h2>How we tested this website</h2>")
  expect_equal(
    paste(output$children[[28]]),
    "<h2>What we're doing to improve accessibility</h2>"
  )
  expect_equal(
    paste(output$children[[31]]),
    "<h2>Preparation of this accessibility statement</h2>"
  )
})

test_that(
  "Params occur in expected places",
  {
    expect_true(
      grepl(
        "https://department-for-education.shinyapps.io/dfe-shiny-template",
        paste0(output$children[[2]])
      )
    )
    expect_true(
      grepl(
        "https://github.com/dfe-analytical-services/shiny-template/issues",
        paste0(output$children[[30]])
      )
    )
  }
)
