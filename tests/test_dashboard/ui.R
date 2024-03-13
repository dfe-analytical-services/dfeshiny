ui <- function(input, output, session) {
  fluidPage(
    shinyjs::useShinyjs(),
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c("https://department-for-education.shinyapps.io/dfe-shiny-template/",
                "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"),
      publication_name = "Explore Education Statistics Publication",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"),
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
  )
}
