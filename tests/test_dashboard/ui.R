ui <- function(input, output, session) {
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
    cookie_banner_ui(name = "My DfE R-Shiny data dashboard"),
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      support_panel(
        team_email = "statistics.development@education.gov.uk",
        repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
        form_url = "https://forms.office.com"
      ),
      cookies_panel_ui(google_analytics_key = ga_key) # nolint: [object_usage_linter]
    )
  )
}
