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

  shiny::observeEvent(input$`cookies_banner-cookies_link`, {
    shiny::updateTabsetPanel(session, "left_nav", selected = "cookies_panel")
  })

  # Navigation ================================================================
  shiny::observeEvent(input$support_nav, {
    shiny::updateTabsetPanel(session, "left_nav", selected = "support_panel")
  })

  shiny::observeEvent(input$accessibility_nav, {
    shiny::updateTabsetPanel(session, "left_nav", selected = "accessibility_panel")
  })

  shiny::observeEvent(input$cookies_nav, {
    shiny::updateTabsetPanel(session, "left_nav", selected = "cookies_panel")
  })

  shiny::observeEvent(input$text_example_nav, {
    shiny::updateTabsetPanel(session, "left_nav", selected = "text_example_panel")
  })
}
