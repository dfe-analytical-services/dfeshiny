server <- function(input, output, session) {
  # Cookies testing ===========================================================
  shinyjs::runjs(
    'Cookies.remove("dfe_analytics");
    getCookies();'
  )

  output$cookie_status <- cookie_banner_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key, # nolint: [object_usage_linter]
    parent_session = session
  )

  cookies_panel_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key # nolint: [object_usage_linter]
  )
}
