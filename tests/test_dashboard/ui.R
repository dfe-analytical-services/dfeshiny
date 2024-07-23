ui <- function(input, output, session) {
  shiny::fluidPage(
    shinyjs::useShinyjs(),

    # Custom disconnect =======================================================
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
      ),
      publication_name = "Explore Education Statistics Publication",
      publication_link =
        "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
    ),

    # Cookies =================================================================
    dfe_cookie_script(),
    cookie_banner_ui("cookies_banner"),

    # Panels ==================================================================
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      support_panel(
        team_email = "explore.statistics@education.gov.uk",
        repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
        form_url = "https://forms.office.com"
      ),
      cookies_panel_ui(google_analytics_key = ga_key) # nolint: [object_usage_linter]
    )
  )
}
