server <- function(input, output, session) {

  shinyjs::runjs(
  'Cookies.remove("dfe_analytics");
  getCookies();'
  )

  output$cookie_status <- cookie_banner_server(
    "cookies",
    input_cookies = shiny::reactive(input$cookies),
    parent_session = session,
    google_analytics_key = google_analytics_key # # nolint: [object_usage_linter]
  )


  cookies_panel_server(
    id = "cookies_panel",
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = google_analytics_key # # nolint: [object_usage_linter]
  )
}
