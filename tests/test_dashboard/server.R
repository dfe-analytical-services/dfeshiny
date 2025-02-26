server <- function(input, output, session) {
  # Cookies testing ===========================================================
  shinyjs::runjs(
    'Cookies.remove("dfe_analytics");
    getCookies();'
  )

  output$cookies_status <- cookies_banner_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key, # nolint: [object_usage_linter]
    parent_session = session
  )

  cookies_panel_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key # nolint: [object_usage_linter]
  )

  output$reactable_example <- reactable::renderReactable(
    dfe_reactable(mtcars |> dplyr::select("mpg", "cyl", "hp", "gear"))
  )

  shiny::observe({
    dfeshiny::set_bookmark_include(session, input, bookmarking_whitelist) # nolint: [object_usage_linter]
  })

  shiny::observe({
    # Trigger this observer every time an input changes
    shiny::reactiveValuesToList(input)
    session$doBookmark()
  })
}
