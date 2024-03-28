library(shinytest2)

google_analytics_key <- "ABCDE12345" # set a test GA key
suppressMessages(devtools::load_all(".")) # load dfeshiny functions

options(shiny.autoload.r = FALSE)

cookie_app <- shinyApp(
  shiny::fluidPage(
    shinyjs::useShinyjs(),
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/" # nolint: [line_length_linter]
      ),
      publication_name = "Explore Education Statistics Publication",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools" # nolint: [line_length_linter]
    ),
    dfe_cookie_script(),
    cookie_banner_ui("cookies"),
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      support_panel(
        team_email = "statistics.development@education.gov.uk",
        repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
        form_url = "https://forms.office.com"
      )
    )
  ),
  function(input, output, session) {
    output$cookie_status <- cookie_banner_server(
      "cookies",
      input_cookies = shiny::reactive(input$cookies),
      input_clear = shiny::reactive(input$cookie_consent_clear),
      parent_session = session,
      google_analytics_key = google_analytics_key # # nolint: [object_usage_linter]
    )
  }
)

# Run the app
app <- AppDriver$new(
  cookie_app,
  name = "cookie_consent",
  height = 846,
  width = 1445,
  load_timeout = 45 * 1000,
  timeout = 20 * 1000,
  wait = TRUE,
  expect_values_screenshot_args = FALSE
)

# Wait for it to load
app$wait_for_idle(500)

# Start UI tests ==============================================================

app$click("cookie_consent_clear")
test_that("App loads", {
  app$expect_values()
})

app$click("cookies-cookie_accept")
test_that("Cookies accepted", {
  app$expect_values()
})

app$click("cookie_consent_clear")
test_that("Cookies reset", {
  app$expect_values()
})

app$click("cookies-cookie_reject")
test_that("Cookies rejected", {
  app$expect_values()
})
