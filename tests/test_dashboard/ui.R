ui <- function(input, output, session) {
  fluidPage(
    shinyjs::useShinyjs(),
    dfe_cookie_script(),
    cookie_banner_ui("cookies"),
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      support_panel(
        team_email = "statistics.development@education.gov.uk",
        repo_name = "dfeshiny",
        form_url = "https://forms.office.com"
      )
    )
  )
}
