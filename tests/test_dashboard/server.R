server <- function(input, output, session) {
  output$cookie_status <- cookie_banner_server(
    "cookies",
    input_cookies = shiny::reactive(input$cookies),
    input_clear = shiny::reactive(input$cookie_consent_clear),
    parent_session = session,
    google_analytics_key = google_analytics_key # # nolint: [object_usage_linter]
  )
}
